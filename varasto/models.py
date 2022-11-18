from asyncio.windows_events import NULL
from datetime import datetime
from email.policy import default
from pickle import NONE
from django.contrib.auth.models import AbstractUser, User, PermissionsMixin
from django.db import models
from django.utils.translation import gettext as _
import pytz
from django.template.defaulttags import register
import operator
from django.conf import settings
from django.core.validators import MaxValueValidator, MinValueValidator
from decimal import *



# Сделать три таблицы места, где будут сделаны константы RACK = [A, B, C...], SHELF[0-9], PLACE[0-20]
# Из Storage_place на них будет ссылка, а также ссылка на Storage_name !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Tietäkö työntekija tavaran paikka kun hän lisää uusi tavara? 
# Нужно добавить Foreign key на Storage в Goods
class Storage_place(models.Model):
    rack = models.CharField(max_length=20, blank=True, null=True) # Voi olla työntekija, joilla on oikeuksia lisätä tavara ei tiedä paikan numero
    shelf = models.CharField(max_length=20, blank=True, null=True)
    place = models.CharField(max_length=20, blank=True, null=True)
    def __str__(self):
        return '%s %s %s' % (self.rack, self.shelf, self.place)

class Storage_name(models.Model):
    name = models.CharField(max_length=30)
    storage_code = models.CharField(max_length=2, blank=True, null=True)
    storage_place = models.ForeignKey(Storage_place, on_delete=models.PROTECT, blank=True, null=True)

    def __str__(self):
        return '%s' % (self.name)

class CustomUser(AbstractUser, PermissionsMixin):
    # _() gettext:n kautta django voi kääntää tekstit muille kielille 
    ROLE = [
        ("student", _("Oppilas")), # Opiskelia ei voi kirjautua ja tehdä mitään palvelussa
        ("student_extended", _("Oppilas laajennetut oikeudet")), # Okeus, joka antaa opiskelioille päästä Varasto palveluun ja hän voi alkaa ja päättää vuokra tapahtuma.
        ("storage_employee", _("Varastotyöntekijä")), # Varasto työntekiä ei voi lisätä, muokata ja posta tavaraa, voi alkaa ja päättää vuokra tapahtuma, antaa oikeuksia opiskelioille
        ("management", _("Hallinto")), # Taloushallinto ei voi lainata tavara, mutta voi antaa oikeuksia. Voi katsoa tapahtumat.
        ("teacher", _("Opettaja")),
        ("super", _("Super user")),
    ]
    group = models.CharField(max_length=15, blank=True, null=True)
    phone = models.CharField(max_length=15)
    code = models.CharField(max_length=10, blank=True, null=True) # Voi olla Null, koska opettajien ja työntekijoiden koodi asetetaan käsiin
    photo = models.ImageField(upload_to='images/students/', blank=True, null=True) # Сделать подпапки
    role = models.CharField(max_length=255, choices=ROLE, default="student")
    responsible_teacher = models.ForeignKey('self', on_delete=models.SET_NULL, blank=True, null=True)
    # Lisää funktio tässä, joka tarkistaa responsible_teacher kentä ja laitaa sinne vain USER:t joilla role=teacher or storage_employee (storage_employee voi olla teacher)
    storage = models.ForeignKey(Storage_name, on_delete=models.PROTECT, blank=True, null=True)
    # REQUIRED_FIELDS = ['code']

    def __str__(self):
        return '%s' % (self.username,)
        # return '%s %s %s %s %s %s %s %s' % (self.first_name, self.last_name, self.username, self.password,
        # self.phone, self.email, self.code, self.photo)
    
    def get_group_permission(self):
        user = CustomUser.objects.get(username=self)
        return user.groups.get()




class Category(models.Model):
    cat_name = models.CharField(max_length=100)

    def __str__(self):
        return '%s' % (self.cat_name)

class IntegerRangeField(models.IntegerField):
    # https://stackoverflow.com/questions/849142/how-to-limit-the-maximum-value-of-a-numeric-field-in-a-django-model
    def __init__(self, verbose_name=None, name=None, min_value=None, max_value=None, **kwargs):
        self.min_value, self.max_value = min_value, max_value
        models.IntegerField.__init__(self, verbose_name, name, **kwargs)
    def formfield(self, **kwargs):
        defaults = {'min_value': self.min_value, 'max_value':self.max_value}
        defaults.update(kwargs)
        return super(IntegerRangeField, self).formfield(**defaults)

class Units(models.Model):
    UNITS = [
        ("unit", _("kpl")),
        ("litre", _("l")),
        ("kilogram", _("kg")),
        ("meter", _("m")),
    ]
    unit = models.CharField(max_length=50, choices=UNITS, blank=True, null=True)
    def __str__(self):
        return '%s' % (self.unit)

class Goods(models.Model):
    UNITS = [
        ("unit", _("kpl")), # TODO Poistaa eng version of items
        ("litre", _("l")),
        ("kilogram", _("kg")),
        ("meter", _("m")),
    ]
    ITEM_STATUS = [
        ("available", _("saatavilla")),
        ("not_available", _("ei saatavilla")),
        ("under_repair", _("korjaamassa")),
    ]
    cat_name = models.ForeignKey(Category, on_delete=models.PROTECT, blank=True, null=True)
    item_name = models.CharField(max_length=150, blank=True, null=True)
    brand = models.CharField(max_length=150,)
    model = models.CharField(max_length=150, blank=True, null=True)
    item_type = models.CharField(max_length=100, blank=True, null=True)
    size = models.CharField(max_length=50, blank=True, null=True)
    parameters = models.CharField(max_length=100, blank=True, null=True)
    # pack = models.CharField(max_length=50, blank=True, null=True)
    contents = models.DecimalField(max_digits=11, decimal_places=4, blank=True, null=True)
    # Created new Class IntegerRangeField to limit values from min to max 
    amount = IntegerRangeField(default=1, min_value=1, max_value=50, blank=True, null=True) # Jos tavaran kategori on kulutusmateriaali, käytetään amount kentä ja yksikkö
    units = models.CharField(max_length=50, choices=UNITS, blank=True, null=True) # Jos tavaran kategori on kulutusmateriaali, käytetään amount kentä ja yksikkö
    picture = models.ImageField(upload_to=settings.PRODUCT_IMG_PATH, blank=True, null=True) # Make subfolders
    item_description = models.TextField(blank=True, null=True) # Kuvaus
    ean = models.CharField(max_length=13, null=True)
    cost_centre = models.CharField(max_length=100, blank=True, null=True) # Kustannuspaikka
    reg_number = models.CharField(max_length=50, blank=True, null=True) # ??? - poistetaan
    purchase_data = models.DateField(blank=True, null=True) # Hankitapäivä
    purchase_price = models.DecimalField(max_digits=6, decimal_places=2, blank=True, null=True) # Hankitahinta
    purchase_place = models.CharField(max_length=50, blank=True, null=True) # Hankitapaikka
    invoice_number = models.CharField(max_length=50, blank=True, null=True) #16 Laskun numero
    storage = models.ForeignKey(Storage_name, on_delete=models.PROTECT, blank=True, null=True)
    storage_place = models.CharField(max_length=5, blank=True, null=True)
    item_status = models.CharField(max_length=50, choices=ITEM_STATUS, blank=True, null=True) # pitää poistaa taulu
    # Packages amount, package contents, units
    # Pakkausten määrä, pakkauksen sisältö, yksiköt

    # @property
    # def rentable_at(self):
    #     rental_events = Rental_event.objects.all().order_by("item")
    #     event = rental_events.filter(item=self).first()
    #     # event = Rental_event.objects.filter(item=self).order_by("id").first()
    #     print(self.id, event)
    #     if event:
    #         return event.estimated_date
    #     return None


    @property
    def amount_x_pack(self):
        # return "%.1d" % Decimal(self.pack * self.amount)
        # return "%.1f" % Decimal(self.pack * self.amount)
        if not self.contents:
            self.contents = 0
        return Decimal(self.contents * self.amount).normalize()

    @register.filter
    def normalize_dec(num):
        if num:
            return Decimal(num).normalize()
        else:
            return None
        
    @register.filter
    def get_key(dictionary, key):
        # try:
        #     is_true = dictionary[key]
        # except:
        #     is_true = False
        # return is_true
        # return dictionary.get(key)
        # print(key)
        return dictionary.get(key)
    
    @register.filter
    def get_item_inp_amount(dictionary, key):
        try:
            k = dictionary['inp_amount'+str(key)]
        except:
            k = ''
        # print('inp_amount'+str(key), k)
        return k

    @register.filter
    def get_item_radioUnit(dictionary, key):
        try:
            k = dictionary['radioUnit'+str(key)]
        except:
            k = ''
        # print('radioUnit'+str(key), k)
        return k
    
    @property
    def rentable_at(self):
        # Etsitään tavara, joka oleva Rental_event taulussa ja sillä returned_date on None
        event = Rental_event.objects.filter(item=self).filter(returned_date=None).order_by("id").first()
        # print(self.id, event)
        if event:
            # print(self.id, event.item.brand, event.estimated_date)
            return event.estimated_date
        return None

    def __str__(self):
        return '%s' % (self.item_name)
        # return '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s' % (self.cat_name, self.item_name, self.brand, 
        # self.model, self.item_type, self.size, self.parameters, self.package, self.picture,
        # self.item_description, self.cost_centre, self.reg_number, self.purchase_data, self.purchase_price, self.purchase_place, self.invoice_number)





class Rental_event(models.Model):
    item = models.ForeignKey(Goods, related_name='item', on_delete=models.PROTECT)
    storage = models.ForeignKey(Storage_name, on_delete=models.PROTECT, blank=True, null=True)
    renter = models.ForeignKey(CustomUser, related_name='renter', on_delete=models.PROTECT)
    staff = models.ForeignKey(CustomUser, related_name='staff', on_delete=models.PROTECT)
    amount = models.IntegerField(default=1, blank=True, null=True) # Ei tarvitse, koska lainaamisella käytetään Yksi Unikki Tuote
    start_date = models.DateTimeField(blank=True, null=True)
    estimated_date = models.DateTimeField(blank=True, null=True)
    returned_date = models.DateTimeField(blank=True, null=True)
    remarks = models.CharField(max_length=255, blank=True, null=True)

    @property
    def id_start_null (self):
        new_id = str(self.item.id).zfill(8)
        return new_id

    @register.filter
    def get_item(dictionary, key):
        # return dictionary.get(key)
        return dictionary[key]

    @register.filter
    def get_first_date(dictionary):
        if dictionary:
            sorted_events = sorted(dictionary, key=operator.attrgetter('start_date'))
            first_date = sorted_events[0].start_date
        else:
            first_date = ''
        return first_date

    @register.filter
    def get_last_date(dictionary):
        if dictionary:
            sorted_events = sorted(dictionary, key=operator.attrgetter('start_date'))
            last_date = sorted_events[-1].start_date
        else:
            last_date = ''
        return last_date

    @property
    def is_past_due(self):
        now = datetime.now()
        now = pytz.utc.localize(now)
        # self.estimated_date имеет смещение часового пояся, datetime.now() нет.
        # print(type(self.estimated_date))
        # print(f"{self.estimated_date}>{now}")
        # print(self.renter.first_name)
        # print(self.estimated_date > now)
        return self.estimated_date > now

    # Tarkistaminen 
    @property
    def is_user_have_non_returned_item(self):
        result = 0
        now = datetime.now()
        now = pytz.utc.localize(now)
        event = Rental_event.objects.filter(renter = self.renter)
        for e in event:
            if not e.returned_date and e.estimated_date < now: # если товар не вернули еще, и предполаг. дата больше текущей даты, то +1
                # print(e.estimated_date, now)
                result += 1
        # print (self.renter.first_name, ' - ', result)
        return result
        # return f"{self.renter.first_name} {self.renter.last_name}"


    def __str__(self):
        return '%s %s %s' % (self.item, self.estimated_date, self.returned_date)
    # def __str__(self):
    #     return '%s %s %s %s %s %s %s %s %s' % (self.item, self.storage, self.renter, self.staff, self.amount, self.start_date,
    #     self.estimated_date, self.returned_date, self.remarks)


class Staff_event(models.Model):
    staff = models.ForeignKey(CustomUser, on_delete=models.PROTECT, blank=True, null=True)
    item = models.ForeignKey(Goods, on_delete=models.PROTECT, blank=True, null=True)
    # We need to use related_name if we have 2 ForegnKey to same table.
    from_storage = models.ForeignKey(Storage_name, related_name='from_storage', on_delete=models.PROTECT, blank=True, null=True)
    to_storage = models.ForeignKey(Storage_name, related_name='to_storage', on_delete=models.PROTECT, blank=True, null=True)
    event_date = models.DateTimeField(blank=True, null=True)
    remarks = models.CharField(max_length=100, blank=True, null=True)

    def __str__(self):
         return '%s %s %s %s %s %s' % (self.staff, self.item, self.from_storage,
         self.to_storage, self.event_date, self.remarks)


class Settings(models.Model):
    set_name = models.CharField(max_length=50, blank=True, null=True)
    set_value = models.CharField(max_length=50, blank=True, null=True)
    def __str__(self):
        return '%s' % (self.set_name)