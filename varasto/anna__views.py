import operator
from django.shortcuts import redirect, render
import pytz
from .checkUser import *
from django.contrib.auth.decorators import login_required
from django.contrib.auth.decorators import user_passes_test
from datetime import datetime
from .models import User, Goods, Storage_name, Storage_place, Rental_event, Staff_audit, CustomUser, Settings_CustomUser, Settings
from django.core.paginator import Paginator
from .forms import Settings_CustomUserForm
from django.forms import modelformset_factory, inlineformset_factory
from django.db.models import Q
from django.contrib.auth.hashers import make_password
from .storage_settings import *
from django.urls import reverse
from urllib.parse import urlencode


@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def report(request, idx):
    rental_events = Rental_event.objects.filter(renter_id=idx).order_by("-start_date")
    renter = rental_events[0].renter

    now = datetime.now()
    datenow = pytz.utc.localize(now)
    
    context = {
        'rental_events': rental_events,
        'renter': renter,
        'user': request.user,
        'datenow': datenow,
    }

    return render(request, 'varasto/report.html', context)


@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def new_event_goods(request):
    items = Goods.objects.all().order_by("id")
    return render(request, 'varasto/new_event_goods.html', {'items': items})


@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def product_report(request, idx):
    try:
        item = Goods.objects.get(id=idx)
    except:
        item = None
    rental_events = {}
    if item:
        rental_events = Rental_event.objects.filter(item=item).order_by("-start_date")

    now = datetime.now()
    datenow = pytz.utc.localize(now)
    
    context = {
        'rental_events': rental_events,
        'item': item,
        'user': request.user,
        'datenow': datenow,
    }
    
    return render(request, 'varasto/product_report.html', context)


@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def inventory (request):
    items = Goods.objects.all().order_by("id")
    paginator = Paginator(items, ITEMS_PER_PAGE) # Siirtää muuttujan asetukseen

    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    return render(request, 'varasto/inventory.html', {"items": page_obj})



#FUNC new_user
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
@user_passes_test(lambda user: user.has_perm("varasto.change_customuser"))
def new_user(request):
    error = ''
    person = {}
    approved = ''
    if request.method == 'POST':
        if request.POST.get('got_person'):
            username = (request.POST.get('username'))
            group_permission = (request.POST.get('permission'))
            email = (request.POST.get('email'))
            pass1 = (request.POST.get('pass1'))
            pass2 = (request.POST.get('pass2'))
            is_storage_staff = (request.POST.get('is_storage_staff'))
            is_staff = (request.POST.get('is_staff'))
            got_person_id = int((request.POST.get('got_person')))
            check_person = CustomUser.objects.filter(username=username).exclude(id=got_person_id).first()
            if pass1 == pass2:
                try:
                    person = CustomUser.objects.get(id=got_person_id)
                    if person and not check_person:
                        person.username = username if username else person.username # if not username leave the old username
                        person.email = email if email else person.email # if not email leave the old email
                        person.is_storage_staff = 1 if is_storage_staff else 0
                        person.is_staff = 1 if is_staff else 0
                        person.password = make_password(pass1)
                        person.save()
                        group = Group.objects.get(name=group_permission)
                        person.groups.clear()
                        group.user_set.add(person)
                        
                        base_url = reverse('new_user')
                        person_param = urlencode({'search_person': request.GET.get('search_person')})
                        approved_param = urlencode({'approved': 'Tietoa tellennettu!'})
                        url = '{}?{}&{}'.format(base_url, person_param, approved_param)
                        return redirect(url)
                    else:
                        error = "Syötetty käyttäjän nimi on jo olemassa"
                except:
                    error = "Käyttäjää ei löydy"
            else:
                error = "Salasanat eivät täsmää"
        else:
            error = "Ensin pitää hakea käyttäjä, sen jälkeen on mahdollista muokata hänen kentää"
        
        base_url = reverse('new_user')
        got_person = request.GET.get('search_person') if request.GET.get('search_person') else ''
        person_param = urlencode({'search_person': got_person})
        error_param = urlencode({'error': error})
        url = '{}?{}&{}'.format(base_url, person_param, error_param)
        return redirect(url)
    

    if request.method == 'GET':
        search_person = (request.GET.get('search_person'))
        error = request.GET.get('error')
        approved = request.GET.get('approved')
        # print(search_person)
        if search_person and search_person.isnumeric():
            try:
                person = CustomUser.objects.get(code=search_person)
            except:
                return redirect('new_user')
        elif search_person:
            try:
                person = CustomUser.objects.get(username=search_person)
            except:
                return redirect('new_user')
    groups = Group.objects.all()
    context = {
        'person': person,
        'error': error,
        'approved': approved,
        'groups': groups
    }
    return render(request, 'varasto/new_user.html', context)



@login_required()
@user_passes_test(lambda user:user.is_staff)
def storage_settings(request):

    if request.user.storage_id: # Jos userilla ei ole storage_id, niin ei näytetä EMAIL FORM
        filter_by_user = Settings_CustomUser.objects.filter(storage_id=request.user.storage_id).filter(Q(setting_name__set_name='storage_email') | Q(setting_name__set_name='email_pass') | Q(setting_name__set_name='email_server')).order_by('setting_name_id')

        if len(filter_by_user) != 3: # if storage_email, email_pass, email_server not found for this request.user then create them with empty set_value
            for n in range(5, 8):
                item = Settings_CustomUser.objects.create(setting_name_id=n, user=request.user, storage_id=request.user.storage_id, set_value='')
                # print(item)

        filter_by_user = Settings_CustomUser.objects.filter(storage_id=request.user.storage_id).filter(Q(setting_name__set_name='storage_email') | Q(setting_name__set_name='email_pass') | Q(setting_name__set_name='email_server')).order_by('setting_name_id')

        Settings_CustomUser_formset = modelformset_factory(Settings_CustomUser, form=Settings_CustomUserForm, extra=0, fields = '__all__')

        if request.method == "POST":
            formset = Settings_CustomUser_formset(request.POST, request.FILES)
            if formset.is_valid():
                for form in formset:
                    form.user = request.user
                    # item = form.save(commit=False)
                    # item.user = request.user
                    # item.save() 
                    # print(form.cleaned_data)               
                formset.save()
                return redirect('storage_settings')

        # storage_email_form = Settings_CustomUserForm(use_required_attribute=False, initial={'user': request.user, 'setting_name': 5})
        
        formset = Settings_CustomUser_formset(queryset=filter_by_user)
        for key, n in enumerate(filter_by_user): # Get label names from Settings table
            formset[key].new_label = n.setting_name.label

        context = {
            'formset': formset,
        }
    else:
        context = {}
    return render(request, 'varasto/storage_settings.html', context)