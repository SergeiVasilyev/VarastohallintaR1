# ITEMES_LETTER_CODE = 'A'


# ======================================================
# DATA FOR DATABASE GENERATOR (generator is not created)

# Units
UNITS_LIST = ['kpl', 'l', 'kg', 'm', 'm³']

# CONSUMABLES ID in database.
CATEGORY_CONSUMABLES_ID = 1

# CONSUMABLES name in database
CATEGORY_CONSUMABLES = ['Kulutusmateriaali (ruuvit, maalit, johdot)', 'Työkalut', 'Sähkötyökalut']

# / DATA FOR DATABASE GENERATOR (generator is not created)
# ======================================================


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

STORAGE_EMAIL = "info.varasto@gmail.com"
EMAIL_PASS ="mbmxdxuhmjkojukb" 
EMAIL_SERVER = "smtp.gmail.com"


# / Email consts
# ====================================================
