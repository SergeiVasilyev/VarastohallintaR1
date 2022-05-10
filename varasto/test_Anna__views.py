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
    rental_events = Rental_event.objects.filter(renter_id=9)
    renter = rental_events[0].renter
    print(rental_events)

    context = {
        'rental_events': rental_events,
        'renter': renter,
        'user': request.user,
    }


    return render(request, 'varasto/report.html', context)