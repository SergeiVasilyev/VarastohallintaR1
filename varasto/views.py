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
    HttpRequest
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

    if request.method == 'POST': # Jos painettiin Talenna nappi      
        if changed_user and changed_items and estimated_date: # tarkistetaan että kaikki kentät oli täytetty
            renter = CustomUser.objects.get(id=changed_user.id) # etsitaan kirjoitettu vuokraja
            staff = CustomUser.objects.get(id=request.user.id) # etsitaan varastotyöntekija, joka antoi tavara vuokrajalle
            items = Goods.objects.filter(pk__in=[x.id for x in changed_items]) # etsitaan ja otetaan kaikki tavarat, joilla pk on sama kuin changed_items sisällä
            for item in items: # Iteroidaan ja laitetaan kaikki tavarat ja niiden vuokraja Rental_event tauluun
                rental = Rental_event(item=item, 
                            renter=renter, 
                            staff=staff,
                            start_date=datenow,
                            storage_id = staff.storage_id,
                            estimated_date=estimated_date)
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
        'feedback_status': feedback_status
    }
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
                'package': obj.pack if obj.pack else '',
                'ean': obj.ean if obj.ean else '',
                'rentable_at': obj.rentable_at,
                'storage_place': obj.storage_place,
                'storage_name': obj.storage.name,
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
    select_order_field = order_field()[0].replace("__", ".") # Korvataan __ merkki . :hin 
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

@login_required()
@user_passes_test(lambda user: user.has_perm('varasto.add_goods'))
def new_item(request):
    # Permission test
    # user = CustomUser.objects.get(id=request.user.id)
    # print(user.has_perms(user.get_group_permissions()))
    # print(user.get_group_permissions())
    # -------

    try:
        staff = CustomUser.objects.get(id=request.user.id)
    except:
        staff = None
    l = []
    now = datetime.now()
    datenow = pytz.utc.localize(now)
    if request.method == "POST":
        # print('request.POST')
        form = GoodsForm(request.POST, request.FILES)
        staff_event_form = Staff_eventForm(request.POST, request.FILES)
        if form.is_valid():
            item = form.save(commit=False)
            if not item.cat_name.id == 1: # Jos kategoria on Kulutusmateriaali lähetetään kaikki kappalet eri kentään
                l += item.amount * [item] # luo toistuva luettelo syötetystä (item.amount) määrästä tuotteita
                item.amount = 1 # Nollataan amount
                Goods.objects.bulk_create(l) # Lähettää kaikki tietokantaan
            else:
                item.save() # Jos kategoria ei ole Kulutusmateriaali lähetetään kaikki kappalet sama kentään
                form.save()

        if staff_event_form.is_valid():
            staff_event = staff_event_form.save(commit=False)
            staff_event.item = item
            staff_event.staff = staff
            staff_event.to_storage = item.storage
            staff_event.event_date = datenow
            staff_event.save()
        return redirect('new_item')
    else:
        form = GoodsForm(use_required_attribute=False)
        staff_event_form = Staff_eventForm(use_required_attribute=False)

    if request.method == "GET":
        if '_take_picture' in request.GET:
            pic = VideoCamera().take()
            # print('pic', VideoCamera().take()) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    context = {
        'form': form,
        'staff': staff_event_form,
    }
    return render(request, 'varasto/new_item.html', context)


def gen(camera):
    while True:
        frame = camera.get_frame()
        yield (b'--frame\r\n'
                b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n\r\n')
def video_stream(request):
    return StreamingHttpResponse(gen(VideoCamera()),
                    content_type='multipart/x-mixed-replace; boundary=frame')

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
    

