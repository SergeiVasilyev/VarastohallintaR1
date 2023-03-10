import operator
import pprint
import re
import time
from django.forms import DateTimeField, IntegerField
from django.http import (
    HttpResponse,
    JsonResponse,
)
from django.core.paginator import Paginator
from django.shortcuts import redirect, render
from django.contrib.auth import authenticate, login, logout
import pytz
from .forms import CustomUserForm, GoodsForm, Staff_auditForm
from .checkUser import *
from django.views.decorators.csrf import csrf_protect, csrf_exempt
from django.contrib.auth.decorators import login_required
from django.contrib.auth.decorators import user_passes_test
from datetime import datetime, timedelta
from .models import User, Goods, Storage_name, Storage_place, Rental_event, Staff_audit, CustomUser, Settings, Units, Settings_CustomUser, Category

from django.db.models import Min, Max
from .test_views import test

from .anna__views import report, new_event_goods, product_report, inventory, new_user, storage_settings

from django.db.models import Q, CharField

from .storage_settings import *
from .services import _save_image
from .services import *

from django.conf import settings
from decimal import *
from django.core.serializers import serialize

from django.db.models import F, Func, OuterRef, Subquery, Exists, When, Case, Value
from django.urls import reverse
from urllib.parse import urlencode
from functools import reduce

from django.contrib.postgres.search import SearchQuery, SearchRank, SearchVector





@login_required()
@user_passes_test(lambda user:user.is_staff)
@user_passes_test(lambda user: user.has_perm("varasto.change_customuser"))
def grant_permissions(request):
    users = CustomUser.objects.all().order_by("id")
    if request.user.is_superuser:
        pass
    elif request.user.role=="management":
        users = users.exclude(is_superuser=True)
    elif request.user.role=="storage_employee":
        users = users.exclude(is_superuser=True).exclude(role="management")
    else:
        users = {}

    paginator = Paginator(users, ITEMS_PER_PAGE) # Siirtää muuttujan asetukseen
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        "users": page_obj
    }

    return render(request, 'varasto/grant_permissions.html', context)

@login_required()
@user_passes_test(lambda user: user.is_staff)
@user_passes_test(lambda user: user.has_perm("varasto.change_customuser"))
def save_permision(request, idx):
    user = CustomUser.objects.get(id=idx)
    user.role = (request.POST.get('roles'))
    # print(user.role)
    if request.POST.get('roles') == 'storage_employee' or request.POST.get('roles') == 'management':
        user.is_staff = True
        user.is_storage_staff = True
    elif request.POST.get('roles') == 'student_extended':
        user.is_storage_staff = True
    elif request.POST.get('roles') == 'super':
        user.is_staff = True
        user.is_superuser = True
        user.is_storage_staff = True
    else:
        user.is_staff = False
        user.is_superuser = False
        user.is_storage_staff = False
    user.save()

    page_number = request.POST.get('page')

    # return redirect('grant_permissions', page=page_number)
    return redirect(f'/grant_permissions?page={page_number}')



# FUNC renter
# @user_passes_test(is_not_student, redirect_field_name=None)
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
@user_passes_test(lambda user: user.has_perm('varasto.view_customuser'))
def renter(request, idx):
    error = {}
    if request.method == 'POST':
        # print(request.POST.get('rental_close'), request.POST.getlist('set_end_date'))
        # print('search_form: ', request.POST.get('rental_event_id')) # Get rental_event id from hidden Input (renter.html)
        # print("BUTTON", request.POST.get('_close_rent_cons'))
        item = Rental_event.objects.get(id=request.POST.get('rental_event_id'))
        event = Rental_event.objects.get(id=request.POST.get('rental_event_id'))
        product = Goods.objects.get(id=item.item_id)
        now = datetime.now()
        datenow = pytz.utc.localize(now)

        if request.POST.get('rental_close'): # UPDATE DATE
            # print('RENTAL CLOSE')
            sended_date = request.POST.get('rental_close') 
            date_formated = datetime.strptime(sended_date, '%Y-%m-%d') # Make format stringed date to datetime format
            date_localized = pytz.utc.localize(date_formated) # Add localize into datetime date
            # print(item.item.item_name, date_localized)
            item.estimated_date = date_localized # Save new estimated date into database
            item.save()

        # TODO Make exceptions to these functions
        def add_to_goods(returned_num, is_amount):
            if is_amount:
                product.amount += returned_num
                product.amount_x_contents = product.amount * product.contents
            else:
                product.amount_x_contents += returned_num
            product.save()
            return True
        
        def substruct_from_rental_event():
            if return_all:
                if event.amount:
                    event.returned = event.amount
                    # event.amount = 0 # FIXED Check if delete this line
                    event.returned_date = datenow
                    add_to_goods(event.returned, 1)
                elif event.contents:
                    event.returned = event.contents
                    # event.contents = 0 # FIXED Check if delete this line
                    event.returned_date = datenow
                    add_to_goods(event.returned, 0)
                else:
                    return redirect('renter', idx)
                event.save()
            else:
                if event.amount:
                    # print('part amount')
                    if (event.amount - return_part_of_product) >= 0:
                        event.amount -= return_part_of_product
                        event.returned = return_part_of_product
                        event.returned_date = datenow
                        add_to_goods(event.returned, 1)
                    else:
                        return redirect('renter', idx)
                elif event.contents:
                    # print('part amount')
                    if (event.contents - return_part_of_product) >= 0:
                        event.contents -= return_part_of_product
                        event.returned = return_part_of_product
                        event.returned_date = datenow
                        add_to_goods(event.returned, 0)
                    else:
                        return redirect('renter', idx)
                else:
                    return redirect('renter', idx)
                event.save()
            return True
        
        if request.POST.getlist('_close_rent_cons'): # Close rent for consumables
            return_all = request.POST.get('everything_returned')
            return_part_of_product = Decimal(request.POST.get('return_amount'+str(item.id)))
            # print(return_part_of_product)
            if substruct_from_rental_event():
                return redirect('renter', idx)


        if request.POST.getlist('set_end_date'): # CLOSE RENT
            # print('set_end_date')
            item.returned = 1
            now = datetime.now()
            datenow = pytz.utc.localize(now)
            item.returned_date = datenow # Save new estimated date into database
            item.save()
        if request.POST.getlist('set_problem'):
            # print('PROBLEM')
            item.remarks = request.POST.get('remarks')
            item.save()

        if request.POST.getlist('send_email_to_teacher'):
            # print(PRODUCT_NOT_RETURNED_MSG.message.format(renter_first_name=item.renter.first_name, renter_last_name=item.renter.last_name, renter_code=item.renter.code, storage_name=item.storage.name, item_name=item.item.item_name, item_brand=item.item.brand, item_model=item.item.model, item_size=item.item.size, item_parameters=item.item.parameters, item_id=item.item.id, staff_email=item.staff.get_storage_staff))

            subject = PRODUCT_NOT_RETURNED_MSG.subject
            msg = PRODUCT_NOT_RETURNED_MSG.message.format(
                renter_first_name=item.renter.first_name, 
                renter_last_name=item.renter.last_name, 
                renter_code=item.renter.code, 
                storage_name=item.storage.name, 
                item_name=item.item.item_name, 
                item_brand=item.item.brand, 
                item_model=item.item.model, 
                item_size=item.item.size, 
                item_parameters=item.item.parameters, 
                item_id=item.item.id, 
                staff_email=item.staff.get_storage_staff)
            to = [item.renter.responsible_teacher.email, item.renter.email]

            email_alert(subject, msg, to)
            return redirect('renter', idx=item.renter_id)

        if request.POST.getlist('send_email_item_is_damaged'):
            damaged_remarks = request.POST.get('damaged_remarks') if request.POST.get('damaged_remarks') else ''
            subject = DEFECT_IN_PRODUCT_MSG.subject
            msg = DEFECT_IN_PRODUCT_MSG.message.format(
                renter_first_name=item.renter.first_name, 
                renter_last_name=item.renter.last_name, 
                renter_code=item.renter.code, 
                storage_name=item.storage.name, 
                item_name=item.item.item_name, 
                item_brand=item.item.brand, 
                item_model=item.item.model, 
                item_size=item.item.size, 
                item_parameters=item.item.parameters, 
                item_id=item.item.id, 
                staff_email=item.staff.get_storage_staff,
                damaged_remarks=damaged_remarks)
            to = [item.renter.responsible_teacher.email, item.renter.email]

            email_alert(subject, msg, to)
            return redirect('renter', idx=item.renter_id)


    selected_user = CustomUser.objects.get(id=idx)

    storage_filter = storage_f(request.user)
    rental_events = Rental_event.objects.filter(renter__id=idx).filter(**storage_filter).order_by('-start_date')

    is_staff_user_has_permission_to_edit = request.user.has_perm('varasto.change_rental_event')

    paginator = Paginator(rental_events, ITEMS_PER_PAGE) # Siirtää muuttujan asetukseen
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'rental_events': page_obj,
        'selected_user': selected_user,
        'idx': idx,
        'is_staff_user_has_permission_to_edit': is_staff_user_has_permission_to_edit,
    }
    return render(request, 'varasto/renter.html', context)


# FUNC new_event
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
@user_passes_test(lambda user: user.has_perm('varasto.add_rental_event'))
def new_event(request):
    error = {}
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
                changed_user = CustomUser.objects.get(code=request.GET.get('add_user')) # FIXED we can add all people from database
                # changed_user = CustomUser.objects.get(Q(code=request.GET.get('add_user')) & Q(storage_id=storage_id)) if storage_id else CustomUser.objects.get(code=request.GET.get('add_user'))
            except:
                error[1] = "Lainaaja ei löydetty"
        if add_items: # jos item codes kirjoitetiin
            for add_item in add_items:
                # print(add_item, ' ', request.GET.get(add_item))
                try:
                    # Jos storage_id on NULL niin etsitaan tavaraa koko tietokannassa (Adminilla ei ole storage_id)
                    new_item = Goods.objects.get(Q(id=request.GET.get(add_item)) & Q(storage_id=storage_id)) if storage_id else Goods.objects.get(id=request.GET.get(add_item))
                    # if new_item.rentable_at: print(new_item, ' rented')
                    if new_item not in changed_items and new_item.is_possible_to_rent[0] == True: # Onko lisättävä tavara jo lisätty and item not consumable
                        changed_items.append(new_item) # Lisätään jos ei 
                        changed_items[-1].radioUnit = '0' if not new_item.amount else '1'
                        # print(changed_items[-1].id, changed_items[-1].radioUnit)
                    # changed_items.append(Goods.objects.get(Q(id=request.GET.get(add_item)) & Q(storage_id=storage_id))) # saadan kaikki Iteemit changed_items muuttujaan (iteemilla on sama storage id kuin staffilla)
                except:
                    error[2] = "Tavaraa ei löydetty"
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
    
    # FIXED Fix float number problem 4.7989999999999995 // FIXED IN bootstrap-input-spinner.js LIBRARY
    # TODO Если в список уже добавлен один расходный материал, то при добавлении в список нового материала обновляется и поля старого, без кнопки фиксации. Надо исправить, чтобы кнопки разных товаров в списке не влияли друг на друга. На перспективу
    r = re.compile("radioUnit") # Define group of variable from Get query
    inp_fixes = list(filter(r.match, request.GET)) # Put all radioUnit### variables into list, ### - item id
    # print('radioUnit', inp_fixes)
    if inp_fixes:
        for inp_fix in inp_fixes: # Go through all list
            idx_inp_fix = re.sub(r, '', inp_fix) # Get from the name id 
            # print(idx_inp_fix)
            # fix_item = '_fix_item'+str(idx_inp_fix)
            # print('fix_item', fix_item)
            idxf = contains(changed_items, idx_inp_fix) # compare lists, find the index of the change_item list
            # print('idxf', idxf)

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
        error[3] = 'Mitään ei löytynyt'



    def serch_fix_item(idx, inp_fixes):
        for inp_fix in inp_fixes:
            # print('inp_fix ', request.GET.get(inp_fix))
            # print('idx ', idx)
            if idx == int(request.GET.get(inp_fix)):
                return True

    if request.method == 'POST': # Jos painettiin Talenna nappi
        if changed_user and changed_items and estimated_date: # tarkistetaan että kaikki kentät oli täytetty
            try:
                renter = CustomUser.objects.get(id=changed_user.id) # etsitaan kirjoitettu vuokraja
                staff = CustomUser.objects.get(id=request.user.id) # etsitaan varastotyöntekija, joka antoi tavara vuokrajalle
            except:
                error[5] = 'Error: Lainaaja ei löydy'
            items = Goods.objects.filter(pk__in=[x.id for x in changed_items]) # etsitaan ja otetaan kaikki tavarat, joilla pk on sama kuin changed_items sisällä
            
            for item in items: # Iteroidaan ja laitetaan kaikki tavarat ja niiden vuokraja Rental_event tauluun
                kwargs = { # Tehdään sanakirja, jossa kaikki kulutusmateriaalien ja työkalujen kentät ovat samat
                    'item': item, 
                    'renter': renter, 
                    'staff': staff,
                    'start_date': datenow,
                    'storage_id': staff.storage_id,
                    'estimated_date': estimated_date,
                    'amount': 1,
                    # 'units': item.unit if not unit else None
                }
                if item.cat_name_id == CATEGORY_CONSUMABLES_ID:  # Jos se on kulutusmateriaali
                    unit = int(request.GET.get('radioUnit'+str(item.id))) # Saadaan yksikköä 1 on pakkaus kpl, 0 on sisällön määrää
                    item_amount = Decimal(request.GET.get('inp_amount'+str(item.id))) # Saadaan tavaran määrä
                    # print('GET unit', str(item.id), unit)
                    # print('GET item_amount', str(item.id), item_amount, int(item.amount), item.amount_x_contents)
                    if (item_amount <= int(item.amount)) or (item_amount <= item.amount_x_contents): # Tarkistus, onko varastossa tarpeeksi tuotteita?
                        try:
                            if unit: # Jos yksikkö on pakkaus, kpl
                                print('unit', unit)
                                item.amount = int(item.amount) - item_amount
                                contents = item.contents if item.contents else 1
                                item.amount_x_contents = item.amount * contents
                                kwargs['amount'] = item_amount
                            else: # Jos yksikkö on sisällön määrää
                                # amount_x_contents = item.amount * item.contents # formula
                                remaining_contents = item.amount_x_contents - item_amount # vähennä lisätyt tuotteet jäljellä olevista varastossa olevista tuotteista
                                new_amount = remaining_contents // item.contents # jako ilman jäännöstä. Se on uusi pakkausten määrä
                                # print('new_amount', new_amount, remaining_contents, item.contents)
                                # remainder = remaining_contents - (item.contents * new_amount)
                                
                                # Vähennetään jos amount arvo tietokannassa on suurempi kuin uusi new_amount arvo. 
                                # Se tarvitse koska, jos palautetaan sisältö emme lisätään pakkausta, jos se oli nolla pitäisi pysyä samana
                                item.amount = new_amount if item.amount >= new_amount else item.amount 
                                item.amount_x_contents = remaining_contents
                                kwargs['amount'] = None
                                kwargs['contents'] = item_amount
                                kwargs['units'] = item.unit

                            item.save() # Päivitetään tavaoiden määrä varastossa
                        except:
                            raise Exception(f'Tavara {item.id} ei riitä varastossa')
                    else:
                        error[4] = 'Error: Ei tarpeeksi tuotteita varastossa'

                rental = Rental_event(**kwargs) # Lisätään kaikki kentät tietokantaan. Jos lisättävää tavaraa ei ole kulutusmateriaalia, niin contents, amount_x_contents kentillä ovat None
                rental.save()
            changed_user = None
            changed_items = []
            return redirect('renter', idx=renter.id)
        else:
            error[6] = 'Kaikkia kenttiä ei ole täytetty'
            feedback_status = False

    # print('changed_user ', changed_user)
    # print('changed_items ', changed_items)

    storage_filter = storage_f(request.user)
    items = Goods.objects.filter(**storage_filter).order_by("id")
    paginator = Paginator(items, ITEMS_PER_PAGE) # Siirtää muuttujan asetukseen

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
    return render(request, 'varasto/new_event.html', context)


# FUNC is_ajax
def is_ajax(request):
    return request.META.get('HTTP_X_REQUESTED_WITH') == 'XMLHttpRequest'


# FUNC getPersons
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def getPersons(request):
    # print(request.GET)
    json_persons = []
    if is_ajax(request=request):
        if len(request.GET.get('name')) > 1:
            persons = CustomUser.objects.filter(
                Q(first_name__icontains=request.GET.get('name')) |
                Q(last_name__icontains=request.GET.get('name')) |
                Q(username__icontains=request.GET.get('name')) |
                Q(code__icontains=request.GET.get('name'))).order_by('code')
            for person in persons:
                item = {
                    'id': person.id,
                    'first_name': person.first_name,
                    'last_name': person.last_name,
                    'username': person.username,
                    'code': person.code,
                }
                json_persons.append(item) # Make response in json 
    return JsonResponse({'persons': json_persons})


# FUNC getProduct
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def getProduct(request):
    # print(request.GET)
    storage_filter = storage_f(request.user)
    search_text = request.GET.get('name')
    search_words = search_text.split(' ')
    json_goods = []
    if is_ajax(request=request):
        if len(request.GET.get('name')) > 1:
            products = Goods.objects.filter(**storage_filter).filter(
                reduce(operator.or_, (
                    Q(id__icontains=x) | 
                    Q(item_name__icontains=x) | 
                    Q(brand__icontains=x) |
                    Q(ean__icontains=x) |
                    Q(model__icontains=x) for x in search_words))).order_by("id")
            for product in products:
                item = {
                    'id': product.id,
                    'item_name': product.item_name,
                    'brand': product.brand,
                    'model': product.model,
                    'ean': product.ean,
                }
                json_goods.append(item) # Make response in json 
    return JsonResponse({'goods': json_goods})

# FUNC getProduct
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def getProduct2(request):
    # print(request.GET)
    req_name = len(request.GET.get('name')) if request.GET.get('name') else 0
    show_all_product = int(request.GET.get('show_all_product'))
    storage_filter = storage_f(request.user) if not show_all_product else {}

    time.sleep(0.1)

    search_text = request.GET.get('name')
    search_words = search_text.split(' ')

    # vector = SearchVector('item_name', 'brand', 'model', weight='A') + SearchVector('item_type', 'size', 'parameters', weight='D') + SearchVector('id', 'ean', weight='A')
    # vector = SearchVector('item_name', 'brand', 'model', 'item_type', 'size', 'parameters', 'id', 'ean',)
    # query = SearchQuery(search_text, search_type='phrase')
    if req_name > 0:
        # search by full words or text
        goods = Goods.objects.filter(**storage_filter).annotate(search=SearchVector('item_name', 'brand', 'model', 'item_type', 'id', 'ean', 'storage_place'),).filter(search=search_text).order_by("id")
        # goods = Goods.objects.filter(**storage_filter).annotate(rank=SearchRank(vector, query)).filter(rank__gte=0.4).order_by("id")

        # if the text is not found, search by letter. 
        if not goods.all():
            goods = Goods.objects.filter(**storage_filter).filter(
            reduce(operator.or_, (Q(item_name__icontains=x) | 
                                Q(brand__icontains=x) |
                                Q(model__icontains=x) |
                                Q(item_type__icontains=x) |
                                Q(id__icontains=x) |
                                Q(ean__icontains=x) |
                                Q(storage_place__icontains=x)
                                for x in search_words))
            ).order_by("id")
    else:
        goods = Goods.objects.filter(**storage_filter).order_by("id")

    # Get all rental events according received products
    rental_events = Rental_event.objects.filter(item__in=goods).filter(returned_date__isnull=True)
    new_goods = goods.filter(id__in=Subquery(rental_events.values('item')))

    # The request creates query whith all fields and creates a new field is_possible_to_rent, where came estimated_date from rental_event table if:
    # - product is not consumable and product not rented yet,  
    # - product is consumable and product not enough in storage,
    # - Or get None
    paginator = Paginator(goods, ITEMS_PER_PAGE)
    page_number = request.GET.get('page')
    goods_by_page = list(paginator.get_page(page_number).object_list.annotate(
        is_possible_to_rent_field=Case(
            When(Q(
            Q(id__in=new_goods) 
                & ~Q(id__in=rental_events.filter(item__cat_name_id=CATEGORY_CONSUMABLES_ID).values('item_id'))
                )
                | Q(
            Q(id__in=new_goods) 
                & Q(id__in=rental_events.filter(item__cat_name_id=CATEGORY_CONSUMABLES_ID).values('item_id'))
                & Q(Q(id__in=rental_events.filter(item__amount=0).values('item_id')) & Q(id__in=rental_events.filter(item__amount_x_contents=0).values('item_id')))
                ), then=rental_events.filter(item_id=OuterRef('id'))[:1].values('estimated_date')),
            When(Q(id__in=new_goods), then=None),
            default=None)).values('id', 
                'ean','storage__name', 'storage_place', 'cat_name', 'item_name', 'brand', 
                'model', 'item_type', 'size', 'parameters', 'contents', 
                'picture', 'item_description', 'cost_centre',
                'purchase_data', 'purchase_price', 'purchase_place', 
                'invoice_number', 'amount', 'unit__unit_name', 'amount_x_contents', 'is_possible_to_rent_field'))
            # in all links to other fields instead of id query gets names (storage__name, unit__unit_name)

    # ========================
    # Same query in PostgreSQL 
    # WITH full_list AS (
	# SELECT * FROM VARASTO_GOODS where STORAGE_ID = 4 ORDER BY ID
    # ), rental_events AS(
    #     SELECT * FROM VARASTO_RENTAL_EVENT VRE WHERE ITEM_ID IN (SELECT id FROM full_list) AND VRE.RETURNED_DATE isnull ORDER by item_id
    # ), rented_goods AS (
    #     SELECT * FROM full_list WHERE ID IN (SELECT item_id FROM rental_events) order by id
    # )
    # SELECT *,
    # CASE
    #     WHEN full_list.id IN (SELECT item_id FROM rental_events vre INNER JOIN full_list vg on vg.id = vre.item_id inner join varasto_category vc on vc.ID = VG.CAT_NAME_ID where vc.id != 1)
    #     then (select estimated_date from rental_events where item_id = full_list.id LIMIT 1)
    #     WHEN full_list.id in (SELECT item_id FROM rental_events vre INNER JOIN full_list vg on vg.id = vre.item_id INNER JOIN VARASTO_CATEGORY VC on VC.ID = VG.CAT_NAME_ID where VC.ID = 1 and vg.amount = 0 and vg.amount_x_contents = 0 AND VRE.RETURNED_DATE isnull AND vg.STORAGE_ID = 4 ORDER BY vg.ID)
    #     THEN (select estimated_date from rental_events where item_id = full_list.id LIMIT 1)
    #     ELSE NULL
    # end is_possible_to_rent
    # FROM full_list ORDER BY id;
    # ============================

    return JsonResponse({'goods_by_page': goods_by_page, 'page': page_number, 'num_pages': paginator.num_pages}, safe=False)



# FUNC getProducts
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def getProducts(request):
    data = []
    if is_ajax(request=request):
        # items = Goods.objects.all().order_by("id")
        storage_filter = storage_f(request.user)
        items = Goods.objects.filter(**storage_filter).order_by("id")
        paginator = Paginator(items, ITEMS_PER_PAGE) # Siirtää muuttujan asetukseen

        page_number = request.GET.get('page')
        page_obj = paginator.get_page(page_number)
        for obj in page_obj:
            item = {
                'id': obj.id,
                'picture': settings.STATIC_URL + str(obj.picture),
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
                'cat_name_id': obj.cat_name_id if obj.cat_name_id else '',
                'amount': obj.amount if obj.amount else '',
                'contents': obj.contents if obj.contents else '',
                'amount_x_contents': obj.amount_x_contents.normalize() if obj.amount_x_contents else '',
                'unit': obj.unit.unit_name if obj.unit else '',
            }
            data.append(item)
            # print(settings.STATIC_URL + str(obj.picture))
    return JsonResponse({'items': data, })


# FUNC login_view
def login_view(request):
    if not request.user.is_authenticated:
        if request.method == 'POST':
            username = request.POST['username']
            password = request.POST['password']
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user) # не логинить, если не прошел проверку
                # if user_check(user) and is_not_student(user):
                # if user.is_authenticated and user.is_staff:
                if user.is_authenticated and user.is_storage_staff:
                    return redirect(get_rental_events_page(user))
                # elif not is_not_student(request.user):
                #     return redirect('products')
                else:
                    return HttpResponse(f"<html><body><h1>Ei ole okeuksia päästä järjestelmään</h1><a href='/logout'>Logout1</a></body></html>") # Tässä voimme tehdä Timer, 10 sec jälkeen tehdään LOGOUT
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
        # if user_check(request.user) and is_not_student(request.user):
        if request.user.is_authenticated and request.user.is_storage_staff:
            return redirect(get_rental_events_page(request.user))
        # elif not is_not_student(request.user):
        #     return redirect('products')
        else:
            return HttpResponse("<html><body><h1>Ei ole okeuksia päästä järjestelmään</h1><a href='/logout'>Logout2</a></body></html>") # Tässä voimme tehdä Timer, 10 sec jälkeen tehdään LOGOUT

# FUNC logout
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


# FUNC rental_events_goods
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def rental_events_goods(request):
    # Filteroi storage nimen mukaan, jos käyttäjillä Superuser oikeus niin näytetään kaikki tapahtumat kaikista varastoista
    storage_filter = storage_f(request.user)
    start_date_range = start_date_filter(request.GET.get('rental_start'), request.GET.get('rental_end'))
    order_filter = ['-'+order_field(request.user)[0], 'renter'] if order_filter_switch(request.user) else [order_field(request.user)[0], 'renter']

    events = Rental_event.objects.filter(returned_date__isnull=True).filter(**storage_filter).filter(**start_date_range).order_by(*order_filter)

    first_date = events[0].start_date if not order_filter_switch(request.user) else events.reverse()[0].start_date
    last_date = events.reverse()[0].start_date if not order_filter_switch(request.user) else events[0].start_date

    paginator = Paginator(events, ITEMS_PER_PAGE) # Siirtää muuttujan asetukseen
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'events': page_obj,
        'first_date': first_date,
        'last_date': last_date,
        'order_switcher': order_filter_switch(request.user),
        'order_field': order_field(request.user)[1],
        'all_order_fields': RENTAL_PAGE_ORDERING_FIELDS_D,
    }
    return render(request, 'varasto/rental_events_goods.html', context)


# FUNC rental_events
# @user_passes_test(lambda user: user.has_perm('varasto.view_rental_event'))
# @user_passes_test(is_not_student, redirect_field_name=None)
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def rental_events(request):
    # FIXID in is_user_have_non_returned_item property. When renter get product in another storage his mark may be red, if one of storage he has not returned products. Marker needs highlight by storage.
    storage_filter = storage_f(request.user)
    start_date_range = start_date_filter(request.GET.get('rental_start'), request.GET.get('rental_end'))
    select_order_field = order_field(request.user)[0].replace("__", ".") # Korvataan __ merkki . :hin, koska myöhemmin käytetään sorted()
    all_order_fields_nolast = RENTAL_PAGE_ORDERING_FIELDS_D.copy() # Kloonataan dictionary
    all_order_fields_nolast.pop(list(RENTAL_PAGE_ORDERING_FIELDS_D.keys())[-1]) # Poistetaan viimeinen elementti sanakirjasta (item__brand). Koska emme voi lajitella groupiroitu lista brandin kentän mukaan

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
    grouped_events = sorted(grouped_events1, key=operator.attrgetter(select_order_field), reverse=order_filter_switch(request.user))

    paginator = Paginator(grouped_events, ITEMS_PER_PAGE) # Siirtää muuttujan asetukseen
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'grouped_events': page_obj,
        'events': events,
        'order_switcher': order_filter_switch(request.user),
        'order_field': order_field(request.user)[1],
        'all_order_fields': all_order_fields_nolast,
    }
    return render(request, 'varasto/rental_events.html', context)



# FUNC get_photo
def get_photo(request):
    picData = request.POST.get('picData')
    img = _save_image(picData)
    # print(img)
    return HttpResponse("<html><body><h1>SAVED</h1></body></html>") 


# FUNC edit_item
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
@user_passes_test(lambda user: user.has_perm('varasto.change_goods'))
# @user_passes_test(is_same_storage, redirect_field_name='product')
def edit_item(request, idx):
    storage_filter = storage_f(request.user) # if storage_filter is empty means superuser, management or student
    try:
        item = Goods.objects.get(id=idx)
        # print(item.storage, request.user.storage)
        if item.storage != request.user.storage and storage_filter: 
            error = "Voi muokata vain tavaroita sijäitsevä sama varastossa"
            return redirect('product', idx=idx)
    except:
        pass
    
    l = []
    error_massage = ''
    camera_picture = request.POST.get('canvasData')
    get_item = Goods.objects.get(id=idx)
    unit = get_item.unit
    cat_name = get_item.cat_name
    cat_name_id = get_item.cat_name_id
    storage = get_item.storage
    amount = get_item.amount
    contents = get_item.contents

    if request.method == "POST":
        form = GoodsForm(request.POST, request.FILES, instance=get_item)
        if form.is_valid():
            item = form.save(commit=False)
            # print('item.picture=', item.picture)
            try:
                if not item.picture:
                    new_picture = PRODUCT_IMG_PATH + _save_image(camera_picture, request.POST.get('csrfmiddlewaretoken'))
                else:
                    new_picture = request.FILES['picture']
                item.picture = new_picture
            except:
                pass
                # print('get_item.picture=', get_item.picture)

            if cat_name_id == CATEGORY_CONSUMABLES_ID:
                # print('item.amount_x_contents', item.amount_x_contents)
                if (item.amount - amount) > 0:
                    new_amount_x_contents = (item.amount - amount) * contents
                    item.amount_x_contents += new_amount_x_contents
                if (item.amount - amount) < 0:
                    new_amount_x_contents = (amount - item.amount) * contents
                    item.amount_x_contents -= new_amount_x_contents

            item.contents = contents # Ei saa muokata contents
            item.cat_name = cat_name
            item.unit = unit
            item.storage = storage if not item.storage else item.storage

            form.save()
            return redirect('product', idx)
        else:
            return HttpResponse('form not valid')
    else:        
        form = GoodsForm(instance=get_item)

    # permission_group = request.user.groups.get()
    
    # storage_employee and student_ext can't edit all fields
    if request.user.groups.filter(name='storage_employee').exists() or request.user.groups.filter(name='student_ext').exists():
        is_storage_employee = ['readonly', 'disabled']
    else:
        is_storage_employee = ['', '']

    event = Rental_event.objects.filter(item_id=idx).filter(returned_date=None)
    is_rented = False
    if event:
        is_rented = True

    context = {
        'form': form,
        'item': get_item,
        'is_storage_employee': is_storage_employee,
        'is_rented': is_rented,
        'error_massage': error_massage
    }
    return render(request, 'varasto/edit_item.html', context)

# FUNC new_item
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def new_item(request):
    l = []
    error_massage = ''
    camera_picture = request.POST.get('canvasData')

    if request.method == "POST":
        form = GoodsForm(request.POST, request.FILES)
        if form.is_valid():
            item = form.save(commit=False)
            if camera_picture:
                new_picture = PRODUCT_IMG_PATH + _save_image(camera_picture, request.POST.get('csrfmiddlewaretoken'))
            elif 'picture' in request.FILES:
                new_picture = request.FILES['picture']
            else:
                new_picture = None

            if item.cat_name:
                if not item.cat_name.id == CATEGORY_CONSUMABLES_ID: # Jos kategoria ei ole Kulutusmateriaali lähetetään kaikki kappalet eri kentään
                    l += item.amount * [item] # luo toistuva luettelo syötetystä (item.amount) määrästä tuotteita
                    item.amount = 1 # Nollataan amount
                    item.contents = 1
                    item.picture = new_picture
                    item.amount_x_contents = None
                    Goods.objects.bulk_create(l) # Lähettää kaikki tietokantaan
                else: # TODO refactor
                    item.picture = new_picture
                    contents = item.contents if item.contents else 1
                    if contents > 0 and item.unit:
                        item.contents = contents
                        item.amount_x_contents = item.amount * contents
                    else:
                        item.unit_id = None
                        item.contents = 1
                        item.amount_x_contents = item.amount
                    item.save() # Jos kategoria ei ole Kulutusmateriaali lähetetään kaikki kappalet sama kentään
                    form.save()
            else:
                error_massage = "Ei valittu kategoriaa"
        
        return redirect('new_item')
    else:
        form = GoodsForm(use_required_attribute=False, initial={'storage': request.user.storage})

    context = {
        'form': form,
        'error_massage': error_massage
    }
    return render(request, 'varasto/new_item.html', context)


# FUNC products
@login_required()
def products(request):
    search_text = request.GET.get('search_text') if request.GET.get('search_text') else ''
    # print('search_text', search_text)

    # Try get a number from checkbox "näytä kaikki"
    try:
        get_show_all = int(request.GET.get('show_all'))
    except:
        get_show_all = 0 # If got exeption, then we show all products from db
    
    if get_show_all: # if got any simbol(s), then show all products
        is_show_all = 1
        storage_filter = {}
    else: # if got 0 show products from same storage where storage employee from
        is_show_all = 0
        storage_filter = storage_f(request.user)# Jos checkbox "Näytä kaikki" ei ole valittu näytetään tavarat sama varastossa, jossa varastotyöntekijällä on valittu
    
    # selected_item = request.GET.get('selected_item')

    items = Goods.objects.filter(**storage_filter).filter(
            Q(id__icontains=search_text) | 
            Q(item_name__icontains=search_text) | 
            Q(brand__icontains=search_text) | 
            Q(ean__icontains=search_text) |
            Q(model__icontains=search_text)).order_by("id")
    paginator = Paginator(items, ITEMS_PER_PAGE) # Siirtää muuttujan asetukseen

    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    static_url = settings.STATIC_URL

    context = {
        'items': page_obj,
        'is_show_all': is_show_all,
        'static_url': static_url,
        'search_text': search_text
    }
    return render(request, 'varasto/products.html', context)


# FUNC product
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
# @user_passes_test(lambda user: user.has_perm('varasto.change_goods'))
def product(request, idx):
    rental_events = None
    selected_item = Goods.objects.get(id=idx)

    storage_filter = storage_f(request.user)
    rental_events = Rental_event.objects.filter(item=selected_item).filter(**storage_filter).order_by('-start_date')

    paginator = Paginator(rental_events, ITEMS_PER_PAGE) # Siirtää muuttujan asetukseen
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    product_barcode = barcode_gen(idx)

    # Calculate the page number this product is on. After deleting the product, we can return to this page
    len_to_self_item = Goods.objects.filter(**storage_filter).filter(id__lt=idx).order_by("id").__len__()
    page_number = (len_to_self_item // ITEMS_PER_PAGE) + 1

    context = {
        'rental_events': page_obj,
        'selected_item': selected_item,
        'idx': idx,
        'product_barcode': product_barcode,
        'next_page': page_number
    }
    return render(request, 'varasto/product.html', context)



# FUNC set_rental_event_view
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def set_rental_event_view(request):
    set_name = Settings.objects.get(set_name='rental_page_view')
    set, new_set = Settings_CustomUser.objects.filter(user=request.user).get_or_create(setting_name=set_name, user=request.user)
    set.set_value = request.GET.get('name')
    set.save()

    return redirect (request.GET.get('name'))


# FUNC set_ordering
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def set_ordering(request):
    set_name = Settings.objects.get(set_name='rental_page_ordering')
    set, new_set = Settings_CustomUser.objects.filter(user=request.user).get_or_create(setting_name=set_name, user=request.user)
    # print(set)
    order = 0 if int(set.set_value) else 1
    set.set_value = order
    set.save()

    # page = Settings.objects.get(set_name='rental_page_view')
    rental_page = get_rental_events_page(request.user)
    return redirect (rental_page)


# FUNC set_order_field
@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def set_order_field(request):
    set_name = Settings.objects.get(set_name='rental_page_field_ordering')
    set, new_set = Settings_CustomUser.objects.filter(user=request.user).get_or_create(setting_name=set_name, user=request.user)
    set.set_value = request.GET.get('order')
    set.save()

    # page = Settings.objects.get(set_name='rental_page_view')
    rental_page = get_rental_events_page(request.user)
    return redirect (rental_page)

@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def delete_product(request, idx, next_page):
    staff = CustomUser.objects.get(id=request.user.id)
    item = Goods.objects.get(id=idx)
    item_data_dict = item.__dict__.copy() # Make copy of product instance

    # Delete unnecessary fields in product info
    entries_to_remove = ('_state', 'cat_name_id', 'item_type', 'size', 'parameters', 'item_description', 'picture', 'storage_place', 'item_status', 'cost_centre', 'purchase_data', 'purchase_price', 'purchase_place', 'storage_id', 'cat_name_id', 'ean')
    for k in entries_to_remove:
        item_data_dict.pop(k, None)
    item_data_dict['contents'] = str(item.contents.normalize()) if item.contents else ''
    item_data_dict['amount_x_contents'] = str(item.amount_x_contents.normalize()) if item.amount_x_contents else ''
    # print(item_data_dict)

    user_dict = staff.__dict__.copy() # Make copy of staff instance
    # Delete unnecessary fields in product info
    entries_to_remove = ('_state', 'username', 'password', 'email', 'last_login', 'date_joined', 'is_superuser', 'is_staff', 'is_active', 'group', 'photo', 'role', 'responsible_teacher_id', 'storage_id')
    for k in entries_to_remove:
        user_dict.pop(k, None)
    # print(user_dict)

    # Create record about event in Staff_audit table
    storage = request.user.storage.name if request.user.storage else None
    now = datetime.now()
    datenow = pytz.utc.localize(now)
    staff_audit = Staff_audit.objects.create(
        staff = user_dict,
        item = item_data_dict,
        event_process = 'Delete item',
        to_storage = storage,
        event_date = datenow,
    )
    staff_audit.save()
    
    item.delete()

    base_url = reverse('products')  # 1 URL to reverse
    query_string =  urlencode({'page': next_page})  # 2 page=next_page, save page number where product was
    url = '{}?{}'.format(base_url, query_string)  # 3 /products/?category=42, create url with parameters
    
    return redirect(url)



@login_required()
@user_passes_test(lambda user:user.is_storage_staff)
def burger_settings(request):
    show_full = request.POST.get('show_full')


    burger_setting_dict = Settings.objects.get(set_name='show_full_burger')
    set, new_set = Settings_CustomUser.objects.filter(user=request.user).get_or_create(setting_name=burger_setting_dict, user=request.user)
    set.set_value = show_full
    set.save()

    show_full_burger = set.set_value
    # burger_dict = burger_dict.replace("\'", "\"")
    # burger_settings_json = json.loads(burger_dict)

    return JsonResponse({'show_full_burger': show_full_burger, })


def product_barcode(request, idx):
    item = Goods.objects.get(id=idx)
    product_barcode = barcode_gen(idx)
    context = {
        'product_barcode': product_barcode,
        'item': item,
    }
    return render(request, 'varasto/product_barcode.html', context)

def product_barcode_ean13(request, idx):
    item = Goods.objects.get(id=idx)
    product_barcode = barcode_gen_ean13(item.ean)
    context = {
        'product_barcode': product_barcode,
        'item': item,
    }
    return render(request, 'varasto/product_barcode_ean13.html', context)

@login_required()
@user_passes_test(lambda user:user.is_staff)
@user_passes_test(lambda user: user.is_superuser)
def initilize(request):
    for n in range(len(CATEGORIES)):
        cats = Category.objects.get_or_create(cat_name=CATEGORIES[n])
        # print(cats)

    for n in range(len(UNITS_LIST)):
        units = Units.objects.get_or_create(unit_name=UNITS_LIST[n])


    return HttpResponse('INITIALIZE COMPLETE')




# FUNC filling_storage_place
# storage_place sarakkeen täyttäminen
def filling_storage_place(request):
    # items = Goods.objects.all().order_by("ean")
    # rack = ['A', 'B', 'C']
    # rackid = 0
    # unit = 1
    # shelf = 0

    # for item in items:
    #     if shelf < 9:
    #         shelf += 1
    #     elif unit < 9:
    #         unit += 1
    #         shelf = 1
    #     elif rackid < 3:
    #         rackid += 1
    #         unit = 1
    #         shelf = 1
    #     else:
    #         rackid = 1
    #         unit = 1
    #         shelf = 1

    #     print(rack[rackid]+str(unit)+str(shelf))
    #     # item.storage_place = rack[rackid]+str(unit)+str(shelf)
    #     # item.save()
    
    return HttpResponse("<html><body><h1>RENDERED</h1></body></html>")


# FUNC filling_goods_description
 # Adding description to products from 2-12 fields
def filling_goods_description(request):
    # items = Goods.objects.filter(id__in=[2,3,4,5,6,7,8,9,10,11,12])
    # # for item in items:
    # #     print(item.id)
    # #     print(item.item_description)

    # n = 0
    # new_items = Goods.objects.all().order_by("id")
    # for new_item in new_items:
    #     if new_item.id > 12:
    #         # new_item.item_description = items[n].item_description
    #         # new_item.save()
    #         print(items[n].item_description)
    #     if n < 10:
    #         n += 1
    #     else:
    #         n = 0

    return HttpResponse("<html><body><h1>RENDERED</h1></body></html>")
    

