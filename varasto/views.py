import operator
import re
from django.forms import inlineformset_factory, modelformset_factory
from django.http import (
    HttpResponse,
    HttpResponseBadRequest,
    HttpResponseNotFound,
    HttpResponseRedirect,
    StreamingHttpResponse,
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
from datetime import datetime
from .models import User, Goods, Storage_name, Storage_place, Rental_event, Staff_event, CustomUser
from django.db.models import Count

from django.db.models import Min, Max
from .test_views import test

from .anna__views import report, new_event_goods, product_report

from .capture_picture import VideoCamera
from django.db.models import Q
from .alerts import email_alert







def inventaario_side_window(request):
    return render(request, 'varasto/inventaario_side_window.html')

def person_view(request):
    return render(request, 'varasto/person.html')


@login_required()
@user_passes_test(is_not_student, redirect_field_name=None)
def renter(request, idx):
    # При обновлении даты, нельзя дать возможность менять дату в меньшую сторону!!!
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
            to = item.renter.responsible_teacher.email
            print(subject, text + body, to)
            email_alert(subject, text + body, 'tino.cederholm@gmail.com')
        if request.POST.getlist('send_email_item_is_damaged'):
            subject = "Automaattinen muistutus!"
            text = f"henkilö {item.renter.first_name} {item.renter.last_name} on paluttanut varioittuneen tuotteen: <br>"
            body = f" Tuotteen koodi: {item.item.id} <br> Tuotteen nimi: {item.item.item_name} {item.item.brand} <br> Tuotteen malli: {item.item.model} {item.item.item_type} <br> Tuotteen parametrit: {item.item.size} {item.item.parameters}<br>"
            remarks = f"Vaurion kuvaus: <br> {request.POST.get('damaged_remarks')}"
            to = item.renter.responsible_teacher.email
            print(subject, text + body + remarks, to)
            email_alert(subject, text + body + remarks, 'tino.cederholm@gmail.com')

    selected_user = CustomUser.objects.get(id=idx)
    rental_events = Rental_event.objects.filter(renter__id=idx).order_by('-start_date')
    # print(selected_user)

    now = datetime.now()
    datenow = pytz.utc.localize(now)
    # datenow = datenow.strftime("%d.%m.%Y")
    context = {
        'rental_events': rental_events,
        'selected_user': selected_user,
        'user': request.user,
        'idx': idx,
        'datenow': datenow,
    }
    return render(request, 'varasto/renter.html', context)

@login_required()
def new_event(request):
    now = datetime.now()
    datenow = pytz.utc.localize(now)
    # datenow = now.strftime("%d.%m.%Y")
    changed_user = None
    changed_items = []
    r = re.compile("add_item") # html:ssa Inputit näyttävät kuin add_item<count number>, siksi pitää löytää kaikki
    add_items = list(filter(r.match, request.GET)) # Etsimme request.GET:ssa kaikki avaimet, joissa nimella on merkkijono "add_item"
    # print(list(filter(r.match, request.GET)))

    if '_add_user' or '_add_item' in request.GET: # Tarkistetaan, painettiin nappit vai ei
        if request.GET.get('add_user'): # jos user code on kirjoitettiin
            # print('add_user: ', request.GET.get('add_user'))
            try:
                changed_user = CustomUser.objects.get(code=request.GET.get('add_user')) # saadan user
            except:
                error = "User ei löyty"
        if add_items: # jos item codes kirjoitettiin
            for add_item in add_items:
                # print(add_item, ' ', request.GET.get(add_item))
                try:
                    changed_items.append(Goods.objects.get(id=request.GET.get(add_item))) # saadan kaikki Iteemit changed_items muuttujaan
                except:
                    error = "User ei löyty"

    if '_remove_user' in request.GET: # jos _remove_user nappi painettu, poistetaan changed_user sisällöt
        changed_user = None
        # print('changed_user cleared')

    if '_remove_item' in request.GET: # jos _remove_item nappi painettu, poistetaan item counter mukaan
        # print(request.GET.get('_remove_item'))
        changed_items.pop(int(request.GET.get('_remove_item')))

    if request.method == 'POST': # Jos painettiin Talenna nappi
        get_estimated_date = request.GET.get('estimated_date')
        date_formated = datetime.strptime(get_estimated_date, '%Y-%m-%d') # Make format stringed date to datetime format
        estimated_date = pytz.utc.localize(date_formated) # Add localize into datetime date

        renter = CustomUser.objects.get(id=changed_user.id) # etsitaan kirjoitettu vuokraja
        staff = CustomUser.objects.get(id=request.user.id) # etsitaan varastotyöntekija, joka antoi tavara vuokrajalle
        if request.GET.get('add_user') and add_items: # tarkistetaan että kaikki kentät oli täytetty
            items = Goods.objects.filter(pk__in=[x.id for x in changed_items]) # etsitaan ja otetaan kaikki tavarat, joilla pk on sama kuin changed_items sisällä
            for item in items: # Iteroidaan ja laitetaan kaikki tavarat ja niiden vuokraja Rental_event tauluun
                rental = Rental_event(item=item, 
                            renter=renter, 
                            staff=staff,
                            start_date=datenow,
                            estimated_date=estimated_date) # !!!!!!!!!!!!!!!!!!!!!!!!
                # print(rental)
                rental.save()
        changed_user = None
        changed_items = []
        return redirect('new_event')

    items = Goods.objects.all().order_by("id") # Попробовать передать с помощью AJAX или только после нажатия Lisää tuote

    # print(changed_user, changed_items, request.GET.get('_remove_user'))
    
    context = {
        'changed_user': changed_user,
        'changed_items': changed_items,
        'datenow': datenow,
        'user': request.user,
        'items': items
    }
    return render(request, 'varasto/new_event.html', context)




def login_view(request):
    if not request.user.is_authenticated:
        if request.method == 'POST':
            username = request.POST['username']
            password = request.POST['password']
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)
                # print('sucsess')
                if user_check(user) and is_not_student(user):
                    return redirect('rental_events')
                else:
                    return HttpResponse("<html><body><h1>Ei ole okeuksia päästä tähän sivuun</h1></body></html>") # Tässä voimme tehdä Timer, 10 sec jälkeen tehdään LOGOUT
            else:
                # Pitää rakentaa frontendilla vastaus, että kirjoitettu salasana tai tunnus oli väärin
                return redirect('login')
                # return HttpResponse("<html><body><h1>error</h1></body></html>")
        else:
            form = CustomUserForm()
            context = {'form': form}
            return render(request, 'varasto/login.html', context)
    else:
        if user_check(request.user) and is_not_student(request.user):
            return redirect('rental_events')
        else:
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
    # if not request.user.is_authenticated:
    #     return redirect('login')
    # return render(request, 'varasto/index.html')

def user_recovery(request):
    return render(request, 'varasto/recovery.html')


def base_main(request):
    now = datetime.now()
    datenow = pytz.utc.localize(now)
    # datenow = now.strftime("%d.%m.%Y")
    context = {
        'datenow': datenow,
        'user': request.user
    }
    return render(request, 'varasto/base_main.html', context)

def update_rental_status(request):
    return render(request, 'varasto/update_rental_status.html')

@login_required()
@user_passes_test(is_not_student, redirect_field_name=None)
def rental_events(request):
    # INNER JOIN
    # Rental_event.objects.filter(renter__first_name="Sergey")

    # SUBQUERY
    # SELECT renter_id FROM public.varasto_rental_event WHERE renter_id in (
    # SELECT id from varasto_customuser WHERE last_name = 'Virtanen'
    # ) 
    # subquery = CustomUser.objects.filter(last_name="Virtanen")
    # Rental_event.objects.filter(renter__in=subquery)

    renters_by_min_startdate = Rental_event.objects.values('renter').filter(returned_date__isnull=True).annotate(mindate=Min('start_date')).order_by('renter')
    # grouped_events1 = renters_by_min_startdate.filter(start_date__in=renters_by_min_startdate.values('mindate')).order_by('start_date')
    events = Rental_event.objects.filter(returned_date__isnull=True).order_by('renter', 'start_date')
    grouped_events1 = (
        Rental_event.objects
        .filter(returned_date__isnull=True)
        .filter(
            Q(start_date__in=renters_by_min_startdate.values('mindate')) & 
            Q(renter__in=renters_by_min_startdate.values('renter'))
        )
        .order_by('renter')
        .distinct('renter')
    )
    grouped_events = sorted(grouped_events1, key=operator.attrgetter('start_date'), reverse=True)

    # for i in renters_by_min_startdate:
    #     print(i)
    # for i in events: 
    #     print(i.item, i.renter.id)

    # for i in grouped_events1: 
    #     # print(i)
    #     # print(i['renter'])
    #     print(i.renter_id, i.item, i.start_date)

    now = datetime.now()
    datenow = pytz.utc.localize(now)
    # datenow = now.strftime("%d.%m.%Y")
    context = {
        'grouped_events': grouped_events,
        'events': events,
        'datenow': datenow,
        'user': request.user
    }

    return render(request, 'varasto/rental_events.html', context)



# def new_event_goods(request):
#     return render(request, 'varasto/new_event_goods.html')

def inventory(request):
    now = datetime.now()
    datenow = pytz.utc.localize(now)
    # datenow = now.strftime("%d.%m.%Y")
    context = {
        'datenow': datenow,
        'user': request.user
    }
    return render(request, 'varasto/inventory.html', context)

# def report(request):
#     return render(request, 'varasto/report.html')

def new_user(request):
    now = datetime.now()
    datenow = pytz.utc.localize(now)
    # datenow = now.strftime("%d.%m.%Y")
    context = {
        'datenow': datenow,
        'user': request.user
    }
    return render(request, 'varasto/new_user.html', context)

def grant_permissions(request):
    now = datetime.now()
    datenow = pytz.utc.localize(now)
    # datenow = now.strftime("%d.%m.%Y")
    context = {
        'datenow': datenow,
        'user': request.user
    }
    return render(request, 'varasto/grant_permissions.html', context)


def new_item(request):
    try:
        staff = CustomUser.objects.get(id=request.user.id)
    except:
        staff = None
    # print(staff)
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
            # print('staff saved')
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
        # print('GET')
        if '_take_picture' in request.GET:
            pic = VideoCamera().take()
            # print('pic', VideoCamera().take()) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    
    now = datetime.now()
    datenow = pytz.utc.localize(now)
    context = {
        'form': form,
        'staff': staff_event_form,
        'datenow': datenow
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
    print('is_ajax')
    pic = VideoCamera().take()
    
    return HttpResponse(pic)


def products(request):
    items = Goods.objects.all().order_by("id")
    paginator = Paginator(items, 20) # Siirtää muuttujan asetukseen

    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    now = datetime.now()
    datenow = pytz.utc.localize(now)
    context = {
        'items': page_obj,
        'datenow': datenow
    }
    return render(request, 'varasto/products.html', context)

