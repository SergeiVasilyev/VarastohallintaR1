from .keys import *


# ITEMES_LETTER_CODE = 'A'


# ======================================================
# DATA FOR DATABASE GENERATOR (generator is not created)

# Units
UNITS_LIST = ['kpl', 'l', 'kg', 'm', 'm³']

# CONSUMABLES ID in database.
CATEGORY_CONSUMABLES_ID = 1

# CONSUMABLES name in database
CATEGORIES = ['Kulutusmateriaali (ruuvit, maalit, johdot)', 'Työkalut', 'Sähkötyökalut']

# / DATA FOR DATABASE GENERATOR (generator is not created)
# ======================================================


ITEMS_PER_PAGE = 20

RENTAL_PAGE_VIEW = 'rental_events'

RENTAL_PAGE_ORDERING_FIELDS = ['Alkamispäivä', 'Päättymispäivä', 'Nimi', 'Tavara']

RENTAL_PAGE_ORDERING_FIELDS_D = {
    'start_date': 'Alkamispäivä',
    'estimated_date': 'Päättymispäivä',
    'renter__last_name': 'Lainajan nimi',
    'item__brand': 'Tavara',
}
# print("One line Code Key value: ", list(RENTAL_PAGE_ORDERING_FIELDS_D.keys())[list(RENTAL_PAGE_ORDERING_FIELDS_D.values()).index('Alkamispäivä')])

PRODUCT_IMG_PATH = 'images/goods/'


# ====================================================
# Email consts

STORAGE_EMAIL = EMAIL_FROM_KEY
EMAIL_PASS = EMAIL_PASS_FROM_KEY
EMAIL_SERVER = "smtp.gmail.com"


# MESSAGE TEMPLATE
class Email_msg:
    """
    ARGS: subject, message, signature
    """
    def __init__(self, **kwargs):
        self.subject = kwargs.get('subject', '')
        self.message = kwargs.get('message', '')
        self.signature = kwargs.get('signature', '')

    def show(self):
        print(self.subject, self.message, self.signature)

# Viesti malli, jos tuotetta ei ole palautettu
SUBJECT = "Automaattinen muistutus!"
LINE1 = "Tämä viesti on lähetetty automatisesti, ei kannata vastata. <br> <br>"
LINE2 = "Henkilöllä {renter_first_name} {renter_last_name} (koodi: {renter_code}) on erääntynyt laina {storage_name} varastossa: <br>"
LINE3 = "<b> - {item_name} {item_brand} {item_model} </b> {item_size} {item_parameters}, tuotteen koodi: {item_id} <br><br>"
LINE4 = "Tarkemmat tiedot saat kirjoittamalla varaston työntekijälle {staff_email}"
MESSAGE = LINE1 + LINE2 + LINE3 + LINE4
SIGNATURE = ''
PRODUCT_NOT_RETURNED_MSG = Email_msg(subject=SUBJECT, message=MESSAGE)


# Viesti malli, jos tavarassa / työkalussa on vika
SUBJECT = "Automaattinen muistutus!"
LINE1 = "Tämä viesti on lähetetty automatisesti, ei kannata vastata. <br><br>"
LINE2 = "Henkilö {renter_first_name} {renter_last_name} (koodi: {renter_code}) on palauttanut vaurioituneen tuotteen: <br>"
LINE3 = "<b> - {item_name} {item_brand} {item_model} </b> {item_size} {item_parameters}, tuotteen koodi: {item_id} <br><br>"
REMARKS = "Vaurion kuvaus: <br> {damaged_remarks} <br><br>"
LINE4 = "Tarkemmat tiedot saat kirjoittamalla varaston työntekijälle {staff_email}"
SIGNATURE = ''
MESSAGE = LINE1 + LINE2 + LINE3 + REMARKS + LINE4
DEFECT_IN_PRODUCT_MSG = Email_msg(subject=SUBJECT, message=MESSAGE)


# / Email consts
# ====================================================



# AUTH GROUPS INITIALISATION
AUTH_GROUPS = ['Administrator', 'Management', 'Student', 'Student_ext', 'Storage_employee', 'Teacher']

MANGEMENT_PERM = ['view_logentry', 'add_permission', 'change_permission', 'delete_permission', 'view_permission', 'add_group', 'change_group', 'delete_group', 'view_group', 'add_contenttype', 'change_contenttype', 'delete_contenttype', 'view_contenttype', 'view_session', 'add_customuser', 'change_customuser', 'delete_customuser', 'view_customuser', 'add_category', 'change_category', 'view_category', 'add_goods', 'change_goods', 'delete_goods', 'view_goods', 'add_storage_name', 'change_storage_name', 'delete_storage_name', 'view_storage_name', 'add_storage_place', 'change_storage_place', 'delete_storage_place', 'view_storage_place', 'view_rental_event', 'add_varasto_settings', 'change_varasto_settings', 'view_varasto_settings', 'add_settings', 'change_settings', 'view_settings', 'add_units', 'change_units', 'delete_units', 'view_units', 'add_staff_audit', 'change_staff_audit', 'delete_staff_audit', 'view_staff_audit', 'add_settings_customuser', 'change_settings_customuser', 'delete_settings_customuser', 'view_settings_customuser']

STORAGE_EMPLOYEE_PERM = ['view_logentry', 'add_permission', 'change_permission', 'delete_permission', 'view_permission', 'change_group', 'view_group', 'add_contenttype', 'change_contenttype', 'delete_contenttype', 'view_contenttype', 'add_customuser', 'change_customuser', 'delete_customuser', 'view_customuser', 'add_category', 'change_category', 'delete_category', 'view_category', 'add_goods', 'change_goods', 'delete_goods', 'view_goods', 'add_storage_name', 'change_storage_name', 'delete_storage_name', 'view_storage_name', 'add_storage_place', 'change_storage_place', 'delete_storage_place', 'view_storage_place', 'add_rental_event', 'change_rental_event', 'delete_rental_event', 'view_rental_event', 'add_varasto_settings', 'change_varasto_settings', 'view_varasto_settings', 'view_settings', 'add_units', 'change_units', 'delete_units', 'view_units', 'view_staff_audit', 'add_settings_customuser', 'change_settings_customuser', 'delete_settings_customuser', 'view_settings_customuser']

STUDENT_PERM = ['view_goods']

STUDENT_EXT_PERM = ['view_customuser', 'add_goods', 'change_goods', 'delete_goods', 'view_goods', 'add_rental_event', 'change_rental_event', 'view_rental_event']

TEACHER_PERM = ['view_customuser', 'view_goods', 'view_storage_name', 'view_storage_place', 'view_rental_event']
# /// AUTH GROUPS INITIALISATION

