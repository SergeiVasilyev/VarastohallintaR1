ITEMES_LETTER_CODE = 'A'

RENTAL_PAGE_VIEW = 'rental_events'

RENTAL_PAGE_ORDERING_FIELDS = ['Alkamispäivä', 'Päättymispäivä', 'Nimi', 'Tavara']

RENTAL_PAGE_ORDERING_FIELDS_D = {
    'start_date': 'Alkamispäivä',
    'estimated_date': 'Päättymispäivä',
    'renter__last_name': 'Lainajan nimi',
    'item__brand': 'Tavara',
}
# print("One line Code Key value: ", list(RENTAL_PAGE_ORDERING_FIELDS_D.keys())[list(RENTAL_PAGE_ORDERING_FIELDS_D.values()).index('Alkamispäivä')])

CATEGORY_CONSUMABLES_ID = 1

CATEGORY_CONSUMABLES = ['Kulutusmateriaali (ruuvit, maalit, johdot)', 'Työkalut', 'Sähkötyökalut']
