import pytz

from multiprocessing import context
from .models import Settings
from datetime import datetime



def say_hello(request):
    return {
        'say_hello':"Hello",
    }

def get_rental_events_page(request):
    page = Settings.objects.get(set_name='rental_page_view')

    now = datetime.now()
    datenow = pytz.utc.localize(now)
    # datenow = now.strftime("%d.%m.%Y")

    context = {
        'rental_events_page': page.set_value,
        'datenow': datenow,
        'user': request.user,
    }
    return context