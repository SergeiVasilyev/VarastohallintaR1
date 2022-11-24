from asyncio.windows_events import NULL
import operator
import re
from django.forms import inlineformset_factory, modelformset_factory
from django.http import (
    HttpResponse,
    HttpResponseBadRequest,
    HttpResponseNotFound,
    HttpResponseRedirect,
    JsonResponse,
    StreamingHttpResponse,
    HttpRequest,
    QueryDict
)
from django.core.paginator import Paginator
from django.shortcuts import redirect, render
from django.contrib.auth import authenticate, login, logout
import pytz
from .forms import CustomUserForm, GoodsForm, Staff_eventForm, Staff_eventForm
from .checkUser import *
from django.views.decorators.csrf import csrf_protect, csrf_exempt
from django.contrib.auth.decorators import login_required
from django.contrib.auth.decorators import user_passes_test
from datetime import datetime, timedelta
from .models import User, Goods, Storage_name, Storage_place, Rental_event, Staff_event, CustomUser, Settings
from django.db.models import Count

from django.db.models import Min, Max
from .test_views import test

from .anna__views import report, new_event_goods, product_report

from .capture_picture import VideoCamera
from django.db.models import Q
from .alerts import email_alert
from .storage_settings import *
from .services import _save_image
import PIL.Image as Image
import io
import base64
from django.middleware.csrf import get_token
from django.conf import settings

STATIC_URL = '/varastoapp/static/'




def inventaario_side_window(request):
    return render(request, 'varasto/inventaario_side_window.html')

def person_view(request):
    return render(request, 'varasto/person.html')


@login_required()
# @user_passes_test(is_not_student, redirect_field_name=None)
@user_passes_test(lambda user: user.has_perm('varasto.view_customuser'))
def renter(request, idx):
    # on välttämätöntä kieltää edellisen päivämäärän valitseminen!!
    if request.method == 'POST':
        # print(request.POST.get('rental_close'), request.POST.getlist('set_end_date'))
        # print('search_form: ', request.POST.get('rental_event_id')) # Get rental_event id from hidden Input (renter.html)
        item = Rental_event.objects.get(id=request.POST.get('rental_event_id'))
        if request.POST.get('rental_close'):
            sended_date = request.POST.get('rental_close') 
            date_formated = datetime.strptime(sended_date, '%Y-%m-%d') # Make format stringed date to datetime format
            date_localized = pytz.utc.localize(date_formated) # Add localize into datetime date
            # print(item.item.item_name, date_localized)
            item.estimated_date = date_localized # Save new estimated date into database
            item.save()
        if request.POST.getlist('set_end_date'):
            now = datetime.now()
            datenow = pytz.utc.localize(now)
            item.returned_date = datenow # Save new estimated date into database
            item.save()
        if request.POST.getlist('set_problem'):
            # print('PROBLEM')
            item.remarks = request.POST.get('remarks')
            item.save()
        if request.POST.getlist('send_email_to_teacher'):
            subject = "Automaattinen muistutus!"
            text = f"henkilöllä {item.renter.first_name} {item.renter.last_name} on erääntynyt laina: <br>"
            body = f" Tuotteen koodi: {item.item.id} <br> Tuotteen nimi: {item.item.item_name} {item.item.brand} <br> Tuotteen malli: {item.item.model} {item.item.item_type} <br> Tuotteen parametrit: {item.item.size} {item.item.parameters}"
            # to = item.renter.responsible_teacher.email
            # print(subject, text + body, to)
            email_alert(subject, text + body, 'tino.cederholm@gmail.com')
        if request.POST.getlist('send_email_item_is_damaged'):
            subject = "Automaattinen muistutus!"
            text = f"henkilö {item.renter.first_name} {item.renter.last_name} on paluttanut varioittuneen tuotteen: <br>"
            body = f" Tuotteen koodi: {item.item.id} <br> Tuotteen nimi: {item.item.item_name} {item.item.brand} <br> Tuotteen malli: {item.item.model} {item.item.item_type} <br> Tuotteen parametrit: {item.item.size} {item.item.parameters}<br>"
            remarks = f"Vaurion kuvaus: <br> {request.POST.get('damaged_remarks')}"
            # to = item.renter.responsible_teacher.email
            print(subject, text + body + remarks)
            email_alert(subject, text + body + remarks, 'tino.cederholm@gmail.com')

    selected_user = CustomUser.objects.get(id=idx)
    user = CustomUser.objects.get(username=request.user) # Otetaan kirjautunut järjestelmään käyttäjä, sen jälkeen otetaan kaikki tapahtumat samasta varastosta storage_id=user.storage_id
    
    # TAVARAA EI OLE NÄKYVISSÄ, JOS ADMIN ON KIRJAUTUNUT SISÄÄN
    # Kannattaa tehdä tarkistus, jos kirjautunut Admin tai Hallinto, tai Opettaja
    if user.role == 'super':
        rental_events = Rental_event.objects.filter(renter__id=idx).order_by('-start_date')
    else:
        rental_events = Rental_event.objects.filter(renter__id=idx).filter(storage_id=user.storage_id).order_by('-start_date') 

    context = {
        'rental_events': rental_events,
        'selected_user': selected_user,
        'idx': idx,
    }
    return render(request, 'varasto/renter.html', context)

@login_required()
@user_passes_test(lambda user: user.has_perm('varasto.add_rental_event'))
def new_event(request):
    context = {}
    now = datetime.now()
    datenow = pytz.utc.localize(now)

    feedback_status = True
    estimated_date = None
    estimated_date_issmall = False
    changed_user = None
    changed_items = []
    
    r = re.compile("add_item") # html:ssa Inputit näyttävät kuin add_item<count number>, siksi pitää löytää kaikki
    add_items = list(filter(r.match, request.GET)) # Etsimme request.GET:ssa kaikki avaimet, joissa nimella on merkkijono "add_item"

    staff = CustomUser.objects.get(id=request.user.id)
    storage_id = staff.storage_id

    # print('add_items ', add_items)

    r = re.compile("inp_amount") # html:ssa Inputit näyttävät kuin add_item<count number>, siksi pitää löytää kaikki
    inp_amounts = list(filter(r.match, request.GET)) # Etsimme request.GET:ssa kaikki avaimet, joissa nimella on merkkijono "add_item"
    # print(inp_amounts)

    if '_add_user' or '_add_item' in request.GET: # Tarkistetaan, painettiin nappit vai ei
        if request.GET.get('add_user'): # jos user code on kirjoitettiin
            # print('add_user: ', request.GET.get('add_user'))
            try:
                 # saadan user, jolla on sama storage id kuin staffilla. Jos storage_id on NULL niin ei tarkistetaan storage_id (Adminilla ei ole storage_id)
                changed_user = CustomUser.objects.get(Q(code=request.GET.get('add_user')) & Q(storage_id=storage_id)) if storage_id else CustomUser.objects.get(code=request.GET.get('add_user'))
            except:
                error = "User ei löydetty"
        if add_items: # jos item codes kirjoitetiin
            for add_item in add_items:
                # print(add_item, ' ', request.GET.get(add_item))
                try:
                    # Jos storage_id on NULL niin etsitaan tavaraa koko tietokannassa (Adminilla ei ole storage_id)
                    new_item = Goods.objects.get(Q(id=request.GET.get(add_item)) & Q(storage_id=storage_id)) if storage_id else Goods.objects.get(id=request.GET.get(add_item))
                    # if new_item.rentable_at: print(new_item, ' rented')
                    if new_item not in changed_items and not new_item.rentable_at: # Onko lisättävä tavara jo lisätty?
                        changed_items.append(new_item) # Lisätään jos ei
                    # changed_items.append(Goods.objects.get(Q(id=request.GET.get(add_item)) & Q(storage_id=storage_id))) # saadan kaikki Iteemit changed_items muuttujaan (iteemilla on sama storage id kuin staffilla)
                except:
                    error = "Item ei löydetty"
        if request.GET.get('estimated_date'):
            get_estimated_date = request.GET.get('estimated_date')
            date_formated = datetime.strptime(get_estimated_date, '%Y-%m-%d') # Make format stringed date to datetime format
            estimated_date = pytz.utc.localize(date_formated) # Add localize into datetime date
            if estimated_date <= datenow: # jos eilinen päivä on valittu kentällä, palautetaan virhe
                estimated_date_issmall = True

    if '_remove_user' in request.GET: # jos _remove_user nappi painettu, poistetaan changed_user sisällöt
        changed_user = None

    if '_remove_item' in request.GET: # jos _remove_item nappi painettu, poistetaan item counter mukaan
        changed_items.pop(int(request.GET.get('_remove_item')))


    def contains(list, filter):
        # print(list, filter)
        for count, x in enumerate(list):
            if x.id == int(filter):
                return count
        return -1
    
    # BUG Fix float number problem 4.7989999999999995
    # FIXED При удалении одного товара из списка, у оставшихся сбрасывается amount and radiobtn
    # TODO Если Расходн. материалы уже добавлен, то при добавлении нового материала обновляет и поля старого без кнопки фиксации, надо поправить фиксауию
    r = re.compile("radioUnit") # Define group of variable from Get query
    inp_fixes = list(filter(r.match, request.GET)) # Put all radioUnit### variables into list, ### - item id
    print('radioUnit', inp_fixes)
    if inp_fixes:
        for inp_fix in inp_fixes: # Go through all list
            idx_inp_fix = re.sub(r, '', inp_fix) # Get from the name id 
            # fix_item = '_fix_item'+str(idx_inp_fix)
            # print('fix_item', fix_item)
            idxf = contains(changed_items, idx_inp_fix) # compare lists, find the index of the change_item list
            print('idxf', idxf)

            if idxf != -1:
                changed_items[idxf].radioUnit = request.GET.get(inp_fix) # Set radioUnit value 1 or 0 (first or second radio button)
                changed_items[idxf].item_amount = request.GET.get('inp_amount'+idx_inp_fix) # Set item_amount value 
                changed_items[idxf].fix_item = request.GET.get('_fix_item'+idx_inp_fix) if request.GET.get('_fix_item'+idx_inp_fix) else 1 # Set a fix_item (btn) value: 0, 1. If got none set 1.

            # print('inp_fix', inp_fix)
            # print('idx_inp_fix', idx_inp_fix)

            # print('GET _fix_item'+idx_inp_fix, request.GET.get('_fix_item'+idx_inp_fix)) 

            # print('idxf', idxf)
            # print('radioUnit', request.GET.get(inp_fix))
            # print('item_amount', request.GET.get('inp_amount'+idx_inp_fix))
            # print(changed_items[idxf].id, changed_items[idxf].item_name, changed_items[idxf].item_amount)
    else:
        print('ei löyty mitään')



    def serch_fix_item(idx, inp_fixes):
        for inp_fix in inp_fixes:
            # print('inp_fix ', request.GET.get(inp_fix))
            # print('idx ', idx)
            if idx == int(request.GET.get(inp_fix)):
                return True
         
    # TODO Lisätä tarkistus Kuinka plajon palautetaan takaisin kulutusmaterialia
    # TODO Lopeta nappilla pitää lisätä uusi kenttä, kuinka paljon palautetaan kulutusmaterialia. Jos kentä jäetään tyhjänä - tarkoitta ei mitään palautettu ja merkataan palauttamaksi
    # TODO Kulutusmateriali väri on Keltainen
    # TODO Kun Estimated date on mennyt, automatisesti tehdä Lopeta funktio.
    # TODO Kun annetaan kulutusmaterialit kannata vähentää Goods taulussa tavaran määrä
    # TODO Renter sivulla, kulutusmateriaali rivilla pitää laitta harmaksi nappi Päivitä
    # TODO Automatisesti tarkista ja vähentää Goods taulussa content tai amount määrä

    if request.method == 'POST': # Jos painettiin Talenna nappi
        # TODO Сделать проверку достаточно ли расходных материалов для добавления, несмотря на ограничения во фронтэнде
        # TODO Make Try-exeption to get objects from model
        if changed_user and changed_items and estimated_date: # tarkistetaan että kaikki kentät oli täytetty
            renter = CustomUser.objects.get(id=changed_user.id) # etsitaan kirjoitettu vuokraja
            staff = CustomUser.objects.get(id=request.user.id) # etsitaan varastotyöntekija, joka antoi tavara vuokrajalle
            items = Goods.objects.filter(pk__in=[x.id for x in changed_items]) # etsitaan ja otetaan kaikki tavarat, joilla pk on sama kuin changed_items sisällä
            
            for item in items: # Iteroidaan ja laitetaan kaikki tavarat ja niiden vuokraja Rental_event tauluun
                unit = int(request.GET.get('radioUnit'+str(item.id)))
                item_amount = float(request.GET.get('inp_amount'+str(item.id)))
                kwargs = {
                    'item': item, 
                    'renter': renter, 
                    'staff': staff,
                    'start_date': datenow,
                    'storage_id': staff.storage_id,
                    'estimated_date': estimated_date,
                    'units': item.unit if not unit else None
                }
                if item.cat_name_id == CATEGORY_CONSUMABLES_ID:                   
                    print('GET unit', str(item.id), unit)
                    print('GET item_amount', str(item.id), item_amount)
                    if (item_amount <= item.amount) or (item_amount <= item.contents):
                        print('ITEM AMOUNT <= item.amount or item.contents')
                        if unit:
                            kwargs['amount'] = item_amount
                        else:
                            kwargs['contents'] = item_amount
                        
                rental = Rental_event(**kwargs)
                rental.save()
            changed_user = None
            changed_items = []
            # return redirect('new_event')
            return redirect('renter', idx=renter.id)
        else:
            feedback_status = False

    # print('changed_user ', changed_user)
    # print('changed_items ', changed_items)

    items = Goods.objects.all().order_by("id")
    paginator = Paginator(items, 20) # Siirtää muuttujan asetukseen

    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'changed_user': changed_user,
        'changed_items': changed_items,
        'estimated_date': estimated_date,
        'estimated_date_issmall': estimated_date_issmall,
        'items': page_obj,
        'feedback_status': feedback_status,
    }
    # print(context)
    return render(request, 'varasto/new_event.html', context)

def is_ajax(request):
    return request.META.get('HTTP_X_REQUESTED_WITH') == 'XMLHttpRequest'

def getProducts(request):
    data = []
    if is_ajax(request=request):
        items = Goods.objects.all().order_by("id")
        paginator = Paginator(items, 20) # Siirtää muuttujan asetukseen

        page_number = request.GET.get('page')
        page_obj = paginator.get_page(page_number)
        for obj in page_obj:
            item = {
                'id': obj.id,
                'picture': STATIC_URL + str(obj.picture),
                'item_name': obj.item_name if obj.item_name else '',
                'brand': obj.brand if obj.brand else '',
                'model': obj.model if obj.model else '',
                'item_type': obj.item_type if obj.item_type else '',
                'parameters': obj.parameters if obj.parameters else '',
                'size': obj.size if obj.size else '',
                'package': obj.contents if obj.contents else '',
                'ean': obj.ean if obj.ean else '',
                'rentable_at': obj.rentable_at if obj.rentable_at else '',
                'storage_place': obj.storage_place if obj.storage_place else '',
                'storage_name': obj.storage.name if obj.storage else '', # if in Goods table is no goods.storage_id getting error when try get obj.storage.name, because name isn't in storage
            }
            data.append(item)
    
    return JsonResponse({'items': data, })


def get_rental_events_page():
    page = Settings.objects.get(set_name='rental_page_view')
    return page.set_value


def login_view(request):
    if not request.user.is_authenticated:
        if request.method == 'POST':
            username = request.POST['username']
            password = request.POST['password']
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user) # не логинить, если не прошел проверку
                if user_check(user) and is_not_student(user):
                    return redirect(get_rental_events_page())
                    # return redirect('rental_events')
                else:
                    # return redirect('logout')
                    return HttpResponse("<html><body><h1>Ei ole okeuksia päästä tähän sivuun</h1></body></html>") # Tässä voimme tehdä Timer, 10 sec jälkeen tehdään LOGOUT
            else:
                # Pitää rakentaa frontendilla vastaus, että kirjoitettu salasana tai tunnus oli väärin
                return redirect('login')
                # return HttpResponse("<html><body><h1>error</h1></body></html>")
        else:
            form = CustomUserForm()
            context = {
                'form': form,
                }
            return render(request, 'varasto/login.html', context)
    else:
        if user_check(request.user) and is_not_student(request.user):
            return redirect(get_rental_events_page())
            # return redirect('rental_events')
        else:
            # return redirect('logout')
            return HttpResponse("<html><body><h1>Ei ole okeuksia päästä tähän sivuun</h1></body></html>") # Tässä voimme tehdä Timer, 10 sec jälkeen tehdään LOGOUT


def logout_view(request):
    logout(request)
    return redirect('login')

def recovery_view(request):
    if request.user.is_authenticated:
        return redirect('login')
    return render(request, 'varasto/recovery.html')

def index(request):
    return redirect('login')

def user_recovery(request):
    return render(request, 'varasto/recovery.html')

def base_main(request):
    return render(request, 'varasto/base_main.html')

def update_rental_status(request):
    return render(request, 'varasto/update_rental_status.html')

def storage_f(user):
    # Filteroi storage nimen mukaan, jos käyttäjillä Superuser oikeus niin näytetään kaikki tapahtumat kaikista varastoista
    storage_filter = {}
    try:
        user_group = str(user.groups.get())
    except:
        user_group = ''

    if not user.is_superuser and user_group != 'management':
        storage_filter = { 'storage_id' : user.storage_id }
    return storage_filter

def start_date_filter(start, end):
    if bool(start) & bool(end): # if rental_start and rental_end not NULL
        date_formated = datetime.strptime(start, '%Y-%m-%d') # Make format stringed date to datetime format
        start_date = pytz.utc.localize(date_formated) # Add localize into datetime date

        date_formated = datetime.strptime(end, '%Y-%m-%d') # Make format stringed date to datetime format
        end_date = pytz.utc.localize(date_formated) + timedelta(days=1) # Add 1 day to include this all last day to the list
        start_date_range = { 'start_date__range' : [start_date, end_date] }
    else:
        start_date_range = {} # start_date range is empty if request.GET is empty
    return start_date_range

def order_filter_switch():
    get_ordering = Settings.objects.get(set_name='rental_page_ordering')
    return int(get_ordering.set_value)

def order_field():
    get_order_field = Settings.objects.get(set_name='rental_page_field_ordering')
    order_field_key = list(RENTAL_PAGE_ORDERING_FIELDS_D.keys())[list(RENTAL_PAGE_ORDERING_FIELDS_D.values()).index(get_order_field.set_value)]
    return [order_field_key, RENTAL_PAGE_ORDERING_FIELDS_D[order_field_key]]

def rental_events_goods(request):
    # Filteroi storage nimen mukaan, jos käyttäjillä Superuser oikeus niin näytetään kaikki tapahtumat kaikista varastoista
    storage_filter = storage_f(request.user)
    start_date_range = start_date_filter(request.GET.get('rental_start'), request.GET.get('rental_end'))
    order_filter = ['-'+order_field()[0], 'renter'] if order_filter_switch() else [order_field()[0], 'renter']

    events = Rental_event.objects.filter(returned_date__isnull=True).filter(**storage_filter).filter(**start_date_range).order_by(*order_filter)

    context = {
        'events': events,
        'order_switcher': order_filter_switch(),
        'order_field': order_field()[1],
        'all_order_fields': RENTAL_PAGE_ORDERING_FIELDS_D,
    }
    return render(request, 'varasto/rental_events_goods.html', context)


# @user_passes_test(is_not_student, redirect_field_name=None)
@login_required()
@user_passes_test(lambda user: user.has_perm('varasto.view_goods'))
def rental_events(request):
    storage_filter = storage_f(request.user)
    start_date_range = start_date_filter(request.GET.get('rental_start'), request.GET.get('rental_end'))
    select_order_field = order_field()[0].replace("__", ".") # Korvataan __ merkki . :hin, koska myöhemmin käytetään sorted()
    all_order_fields_nolast = RENTAL_PAGE_ORDERING_FIELDS_D.copy() # Kloonataan dictionary
    all_order_fields_nolast.pop(list(RENTAL_PAGE_ORDERING_FIELDS_D.keys())[-1]) # Poistetaan viimeinen elementti sanakirjasta (item__brand). Koska emme voi lajitella groupiroitu lista brandin kentän mukaan
    # print(RENTAL_PAGE_ORDERING_FIELDS_D)

    renters_by_min_startdate = Rental_event.objects.values('renter').filter(returned_date__isnull=True).filter(**storage_filter).filter(**start_date_range).annotate(mindate=Max('start_date')).order_by('renter')
    events = Rental_event.objects.filter(returned_date__isnull=True).filter(**storage_filter).filter(**start_date_range).order_by('renter', '-start_date')
    grouped_events1 = (
        Rental_event.objects
        .filter(returned_date__isnull=True)
        .filter(**storage_filter)
        .filter(**start_date_range)
        .filter(
            Q(start_date__in=renters_by_min_startdate.values('mindate')) & 
            Q(renter__in=renters_by_min_startdate.values('renter'))
        )
        .order_by('renter')
        .distinct('renter')
    )
    # grouped_events = sorted(grouped_events1, key=operator.attrgetter('start_date'), reverse=order_filter_switch())
    grouped_events = sorted(grouped_events1, key=operator.attrgetter(select_order_field), reverse=order_filter_switch())

    
    context = {
        'grouped_events': grouped_events,
        'events': events,
        'order_switcher': order_filter_switch(),
        'order_field': order_field()[1],
        'all_order_fields': all_order_fields_nolast,
    }
    return render(request, 'varasto/rental_events.html', context)



# def new_event_goods(request):
#     return render(request, 'varasto/new_event_goods.html')

def inventory(request):
    return render(request, 'varasto/inventory.html')

# def report(request):
#     return render(request, 'varasto/report.html')

def new_user(request):
    return render(request, 'varasto/new_user.html')

def grant_permissions(request):
    return render(request, 'varasto/grant_permissions.html')

def get_photo(request):
    picData = request.POST.get('picData')
    img = _save_image(picData)
    print(img)
    return HttpResponse("<html><body><h1>SAVED</h1></body></html>") 

@login_required()
@user_passes_test(lambda user: user.has_perm('varasto.add_goods'))
def new_item(request):
    l = []
    error_massage = ''
    camera_picture = request.POST.get('canvasData')

    if request.method == "POST":
        print('request.POST')
        form = GoodsForm(request.POST, request.FILES)
        if form.is_valid():
            print('FORM is VALID')
            item = form.save(commit=False)
            if not item.picture:
                new_picture = settings.PRODUCT_IMG_PATH + _save_image(camera_picture, request.POST.get('csrfmiddlewaretoken'))
            else:
                new_picture = request.FILES['picture']

            if item.cat_name:
                if not item.cat_name.id == CATEGORY_CONSUMABLES_ID: # Jos kategoria on Kulutusmateriaali lähetetään kaikki kappalet eri kentään
                    l += item.amount * [item] # luo toistuva luettelo syötetystä (item.amount) määrästä tuotteita
                    item.amount = 1 # Nollataan amount
                    item.picture = new_picture
                    Goods.objects.bulk_create(l) # Lähettää kaikki tietokantaan
                else:
                    item.cat_name = None
                    item.contents = None
                    item.picture = new_picture
                    item.save() # Jos kategoria ei ole Kulutusmateriaali lähetetään kaikki kappalet sama kentään
                    form.save()
            else:
                error_massage = "Ei valittu kategoriaa"
        
        return redirect('new_item')
    else:
        form = GoodsForm(use_required_attribute=False)

    context = {
        'form': form,
        'error_massage': error_massage
    }
    return render(request, 'varasto/new_item.html', context)


@csrf_exempt
def take_pacture(request):
    pic = VideoCamera().take()
    
    return HttpResponse(pic)

@login_required()
def products(request):
    items = Goods.objects.all().order_by("id")
    paginator = Paginator(items, 20) # Siirtää muuttujan asetukseen

    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'items': page_obj,
    }
    return render(request, 'varasto/products.html', context)

@login_required()
def product(request, idx):
    user = request.user
    rental_events = None
    selected_item = Goods.objects.get(id=idx)
    if user.has_perm('varasto.view_customuser'):
        rental_events = Rental_event.objects.filter(item=selected_item)

    # if rental_events:
    #     print(rental_events)

    context = {
        'rental_events': rental_events,
        'selected_item': selected_item,
        'idx': idx,
    }
    return render(request, 'varasto/product.html', context)

@login_required()
def set_rental_event_view(request):
    # if 'name' in request.GET:
    #     print('request.GET name =', request.GET.get('name'))

    set = Settings.objects.get(set_name='rental_page_view')
    set.set_value = request.GET.get('name')
    set.save()

    return redirect (request.GET.get('name'))

@login_required()
def set_ordering(request):
    set = Settings.objects.get(set_name='rental_page_ordering')
    order = 0 if int(set.set_value) else 1
    set.set_value = order
    set.save()

    page = Settings.objects.get(set_name='rental_page_view')
    return redirect (page.set_value)

@login_required()
def set_order_field(request):
    set = Settings.objects.get(set_name='rental_page_field_ordering')
    set.set_value = request.GET.get('order')
    set.save()

    page = Settings.objects.get(set_name='rental_page_view')
    return redirect (page.set_value)


# storage_place sarakkeen täyttäminen
def filling_storage_place(request):
    items = Goods.objects.all().order_by("ean")
    rack = ['A', 'B', 'C']
    rackid = 0
    unit = 1
    shelf = 0

    for item in items:
        if shelf < 9:
            shelf += 1
        elif unit < 9:
            unit += 1
            shelf = 1
        elif rackid < 3:
            rackid += 1
            unit = 1
            shelf = 1
        else:
            rackid = 1
            unit = 1
            shelf = 1

        print(rack[rackid]+str(unit)+str(shelf))
        # item.storage_place = rack[rackid]+str(unit)+str(shelf)
        # item.save()
    
    return HttpResponse("<html><body><h1>RENDERED</h1></body></html>")
    
 # Adding description to products from 2-12 fields
def filling_goods_description(request):
    items = Goods.objects.filter(id__in=[2,3,4,5,6,7,8,9,10,11,12])
    # for item in items:
    #     print(item.id)
    #     print(item.item_description)

    n = 0
    new_items = Goods.objects.all().order_by("id")
    for new_item in new_items:
        if new_item.id > 12:
            # new_item.item_description = items[n].item_description
            # new_item.save()
            print(items[n].item_description)
        if n < 10:
            n += 1
        else:
            n = 0

    return HttpResponse("<html><body><h1>RENDERED</h1></body></html>")
    

