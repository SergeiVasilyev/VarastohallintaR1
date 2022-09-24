from .models import Settings



def say_hello(request):
    return {
        'say_hello':"Hello",
    }

def get_rental_events_page(request):
    page = Settings.objects.get(set_name='rental_page_view')
    return { 'rental_events_page': page.set_value }