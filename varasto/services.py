import PIL.Image as Image
import io
import base64
import uuid
import pytz

from .imagebin import byte_data
from django.conf import settings
from pathlib import Path

from django.conf import settings
from .storage_settings import *
from .models import User, Goods, Storage_name, Storage_place, Rental_event, Staff_audit, CustomUser, Settings, Units
from datetime import datetime, timedelta

from email.message import EmailMessage
import smtplib, ssl
from .storage_settings import *


# ======================================================
# EMAIL ALERT

# https://betterdatascience.com/send-emails-with-python/
# https://www.letscodemore.com/blog/smtplib-smtpauthenticationerror-username-and-password-not-accepted/
def email_alert(subject, body, to):
    msg = EmailMessage()
    msg.set_content(body, subtype='html')
    msg['subject'] = subject

    msg['from'] = STORAGE_EMAIL
    msg['to'] = to

    server = smtplib.SMTP(EMAIL_SERVER, 587)
    server.starttls()
    server.login(STORAGE_EMAIL, EMAIL_PASS)
    server.send_message(msg)
    server.quit()


# END EMAIL ALERT
# ======================================================


# ===========================================
# FILE SAVE FUNCTION

def _save_image(byte_data, csrf_token) -> str:
    """Save picture to image/goods directory,
    if generated filename does not exist
    Return: Image filename
    """
    string_encode = bytes(str(byte_data), 'utf-8')
    b = base64.b64decode(string_encode)
    img = Image.open(io.BytesIO(b))

    while True:
        print('While loop')
        new_filename = filename_generator()
        is_file_exist = Path(new_filename['file_path']).is_file()
        if not is_file_exist:
            break

    img.save(new_filename['file_path'])

    return new_filename['image_name']

def filename_generator() -> dict:
    """ Generate file name with prefix <pr_> and extention <.png>
    Return: dict
        [file_path]: Path to product images folder
        [image_name]: Filename
    """
    path = f'.{settings.STATIC_URL[:-1]}{settings.MEDIA_URL[:-1]}/goods/'
    img_prefix = uuid.uuid4().hex
    img_name = f'pr_{img_prefix}.png'
    img_path_name = path+img_name
    return {'file_path': img_path_name, 'image_name': img_name}

# END FILE SAVE FUNCTION
# ==============================================


# GET RENTAL PAGE VIEW
def get_rental_events_page() -> str:
    page = Settings.objects.get(set_name='rental_page_view')
    return page.set_value


# =============================================
# FILTERS
# ---------------------------------------------
# Storage filter
# Filter is empty if user is superuser or management
def storage_f(user) -> dict:
    """Storage filter.
    Return: storage_id
        Filter is empty if user is superuser or management
    """
    # Filteroi storage nimen mukaan, jos käyttäjillä Superuser oikeus niin näytetään kaikki tapahtumat kaikista varastoista
    storage_filter = {}
    try:
        user_group = str(user.groups.get())
    except:
        user_group = ''

    if not user.is_superuser and user_group != 'management':
        storage_filter = { 'storage_id' : user.storage_id }
    return storage_filter


# Datarange filter
def start_date_filter(start, end) -> dict:
    """Datarange filter.
    
    Return: { 'start_date__range' : [start_date, end_date] }
    """
    if bool(start) & bool(end): # if rental_start and rental_end not NULL
        date_formated = datetime.strptime(start, '%Y-%m-%d') # Make format stringed date to datetime format
        start_date = pytz.utc.localize(date_formated) # Add localize into datetime date

        date_formated = datetime.strptime(end, '%Y-%m-%d') # Make format stringed date to datetime format
        end_date = pytz.utc.localize(date_formated) + timedelta(days=1) # Add 1 day to include this all last day to the list
        start_date_range = { 'start_date__range' : [start_date, end_date] }
    else:
        start_date_range = {} # start_date range is empty if request.GET is empty
    return start_date_range

# Ordering filter
def order_filter_switch() -> int:
    """Ordering filter
    Return: 1 or 0
    """
    get_ordering = Settings.objects.get(set_name='rental_page_ordering')
    return int(get_ordering.set_value)

# Ordering field
def order_field() -> list:
    """Get ordering name from Settings table
    All possible fields are written in the storage_settings.py
    Return: list
        [0]: Goods table field name
        [1]: Same name in Finnish
    """
    get_order_field = Settings.objects.get(set_name='rental_page_field_ordering')
    order_field_key = list(RENTAL_PAGE_ORDERING_FIELDS_D.keys())[list(RENTAL_PAGE_ORDERING_FIELDS_D.values()).index(get_order_field.set_value)]
    print('order_field_key', order_field_key)
    print('RENTAL_PAGE_ORDERING_FIELDS_D[order_field_key]', RENTAL_PAGE_ORDERING_FIELDS_D[order_field_key])
    return [order_field_key, RENTAL_PAGE_ORDERING_FIELDS_D[order_field_key]]

# ---------------------------------------------
# END OF FILTERS
# =============================================



