import operator
from django.http import (
    HttpResponse,
    HttpResponseBadRequest,
    HttpResponseNotFound,
)
from django.shortcuts import redirect, render
from django.contrib.auth import authenticate, login, logout
import pytz
from .forms import CustomUserForm
from .checkUser import *
from django.contrib.auth.decorators import login_required
from django.contrib.auth.decorators import user_passes_test
from datetime import datetime
from .models import User, Goods, Storage_name, Storage_place, Rental_event, Staff_event, CustomUser
from django.db.models import Count
from django.db.models.functions import TruncMonth, Trunc
from django.db.models import Min, Max

def report(request):
    rental_events = Rental_event.objects.filter(renter_id=9).order_by("-start_date")
    renter = rental_events[0].renter
    print(rental_events)

    now = datetime.now()
    datenow = pytz.utc.localize(now)
    

    context = {
        'rental_events': rental_events,
        'renter': renter,
        'user': request.user,
        'datenow': datenow,
    }


    return render(request, 'varasto/report.html', context)

# Добавить доступность товара или его местоположение в Goods
# Переименовать test_Anna__views & new_event_goods
def new_event_goods(request):
    # items = Goods.objects.all().order_by("id")
    # notavailable_items = Goods.objects.filter(item_status='not_available').order_by("id")
    # rental_events = Rental_event.objects.filter(item__in=notavailable_items).order_by("item_id")
    # print(rental_events)




    # item in rental_evets ? 
    # + lisätä Itemiin rental_event.estimated_date 

    # rental_events = Rental_event.objects.all().order_by("id")
    items = Goods.objects.all().order_by("id")

    # for item in items:
    #     item.rented = False
    #     # print(item, ' ', item.id)
    #     for rental_event in rental_events:
    #         if not item == rental_event.item and not item.rented: # and rental_event.returned_date
    #             item.rented = False
    #             # print(item.id, rental_event.id, 'False')
    #         else:
    #             item.rented = rental_event.estimated_date
    #             # print(item.id, rental_event.id, 'True')
                
    #     # print(item.id, ' ', item.rented)

    # rental_events_repeat = Rental_event.objects.all().order_by("item") # Delete duplicated rental event items, becose 1 product can rent just one time in same time
    # for i, item in enumerate(rental_events_repeat):
    #     print(rental_events_repeat[i].id, rental_events_repeat[i].item_id, rental_events_repeat[i].item)
    #     if i != 0 and item.item == rental_events_repeat[i-1].item:
    #         del_item = Rental_event.objects.get(id=item.id)
    #         print(del_item.id)
    #         del_item.delete()

    # for item in items: # Code saves in Goods item_status = 'not_available' when the Items is present in the Rent event
    #     # item.rented = False
    #     # print(item, ' ', item.id)
    #     upd_item = Goods.objects.get(id=item.id)
    #     for rental_event in rental_events:
    #         if item != rental_event.item and upd_item.item_status != 'not_available':
    #             print(item.id, item)
    #             upd_item.item_status = 'available'
    #         else:
    #             upd_item.item_status = 'not_available'
    #         upd_item.save()
                
    return render(request, 'varasto/new_event_goods.html', {'items': items})