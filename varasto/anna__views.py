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
from django.core.paginator import Paginator

def report(request, idx):
    rental_events = Rental_event.objects.filter(renter_id=idx).order_by("-start_date")
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


def new_event_goods(request):
    items = Goods.objects.all().order_by("id")
    return render(request, 'varasto/new_event_goods.html', {'items': items})

def product_report(request, idx):
    try:
        item = Goods.objects.get(id=idx)
    except:
        item = None
    rental_events = {}
    if item:
        rental_events = Rental_event.objects.filter(item=item).order_by("-start_date")

    print(rental_events)

    now = datetime.now()
    datenow = pytz.utc.localize(now)
    

    context = {
        'rental_events': rental_events,
        'item': item,
        'user': request.user,
        'datenow': datenow,
    }
    
    return render(request, 'varasto/product_report.html', context)

def inventory (request):
    items = Goods.objects.all().order_by("id")
    paginator = Paginator(items, 20) # Siirtää muuttujan asetukseen

    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    return render(request, 'varasto/inventory.html', {"items": page_obj})

def grant_permissions(request):
    users = CustomUser.objects.all().order_by("id")
    return render(request, 'varasto/grant_permissions.html', {"users": users})