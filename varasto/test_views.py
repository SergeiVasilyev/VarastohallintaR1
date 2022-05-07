from django.shortcuts import redirect, render
from django.contrib.auth import authenticate, login, logout

from .checkUser import *
from datetime import datetime
from .models import Goods, CustomUser, Rental_event
from django.db.models.functions import TruncMonth, Trunc
from django.db.models import Min, Max


def test(request):
    # items = Goods.objects.all()
    # for item in items:
    #     print(item.item_name, item.brand)

    # item = Goods.objects.get(id=5) # Jos tarvitsemme saada vain yksi item
    # print(item.id, item.item_name, item.brand)
    # item.item_name = "BLA lblblblblbl"
    # item.save()
    # item = Goods.objects.get(id=5) # Jos tarvitsemme saada vain yksi item
    # print(item.id, item.item_name, item.brand)


    # items = Goods.objects.filter(item_name="Ford") # Jos tarvitsemme saada kaikki riivit, jossa item_name on Ford
    # # print(items[0].id)
    # for item in items:
    #     print(item.id, item.item_name, item.purchase_data)

    user = CustomUser.objects.get(id=7)
    events = Rental_event.objects.filter(renter=user)
    print(events)

    context = {
        'events': events
    }


    return render(request, 'varasto/test_sergey.html', context)


