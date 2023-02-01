import pytz

from multiprocessing import context
from .models import Settings, CustomUser, Settings_CustomUser
from datetime import datetime
from .storage_settings import *

from django.contrib.auth.decorators import login_required
from django.contrib.auth.decorators import user_passes_test

from django.contrib.auth.models import Group, Permission




def get_rental_events_page(request):
    # page = Settings.objects.get(set_name='rental_page_view')
    user = request.user if request.user.is_authenticated else 1
    try:
        page = Settings_CustomUser.objects.filter(user=user).get(setting_name__set_name='rental_page_view')
    except:
        set_name = Settings.objects.get(set_name='rental_page_view')
        page = Settings_CustomUser.objects.create(user=user, setting_name=set_name, set_value=RENTAL_PAGE_VIEW)

    now = datetime.now()
    datenow = pytz.utc.localize(now)
    # datenow = now.strftime("%d.%m.%Y")

    # user = CustomUser.objects.get(username=request.user)
    # # print(user.get_user_permissions())
    # # print(CustomUser.objects.filter(groups__name='student'))
    # # print(user.groups.get())
    # user_group = user.groups.get()

    try:
        burger_setting_dict = Settings.objects.get(set_name='show_full_burger')
        show_full_burger = int(burger_setting_dict.set_value)
    except:
        show_full_burger = 1

    context = {
        'rental_events_page': page.set_value,
        'datenow': datenow,
        'user': request.user,
        'CATEGORY_CONSUMABLES_ID': CATEGORY_CONSUMABLES_ID,
        'show_full_burger': show_full_burger,
    }
    return context



