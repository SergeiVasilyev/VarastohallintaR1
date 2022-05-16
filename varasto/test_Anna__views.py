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
    rental_events = Rental_event.objects.all().order_by("id")
    items = Goods.objects.all().order_by("id")

    for item in items:
        item.rented = False
        # print(item, ' ', item.id)
        for rental_event in rental_events:
            if not item == rental_event.item and not item.rented:
                item.rented = False
                print(item.id, rental_event.id, 'False')
            else:
                item.rented = rental_event.estimated_date
                print(item.id, rental_event.id, 'True')
                
        # print(item.id, ' ', item.rented)


    return render(request, 'varasto/new_event_goods.html', {'items': items})