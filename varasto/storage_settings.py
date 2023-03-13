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

ITEMS_ON_A_PAGE = 20
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



