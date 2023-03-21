from datetime import datetime
from django.contrib.auth.models import AbstractUser, User, PermissionsMixin
from django.db import models
from django.utils.translation import gettext as _
import pytz
from django.template.defaulttags import register
import operator
from django.conf import settings
from django.core.validators import MaxValueValidator, MinValueValidator
from decimal import *
from .storage_settings import *
from html.parser import HTMLParser





class Storage_place(models.Model):
    rack = models.CharField(max_length=20, blank=True, null=True) # Voi olla työntekija, joilla on oikeuksia lisätä tavara ei tiedä paikan numero
    shelf = models.CharField(max_length=20, blank=True, null=True)
    place = models.CharField(max_length=20, blank=True, null=True)
    def __str__(self):
        return '%s %s %s' % (self.rack, self.shelf, self.place)

class Storage_name(models.Model):
    name = models.CharField(max_length=30)
    storage_code = models.CharField(max_length=5, blank=True, null=True)

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
    is_storage_staff = models.BooleanField(default=False)
    group = models.CharField(max_length=15, blank=True, null=True)
    phone = models.CharField(max_length=15, blank=True, null=True)
    code = models.CharField(max_length=10, blank=True, null=True) # Voi olla Null, koska opettajien ja työntekijoiden koodi asetetaan käsiin
    photo = models.ImageField(upload_to='images/varastousers/', blank=True, null=True) # Сделать подпапки
    role = models.CharField(max_length=255, choices=ROLE, default="student")
    responsible_teacher = models.ForeignKey('self', on_delete=models.SET_NULL, blank=True, null=True)
    storage = models.ForeignKey(Storage_name, on_delete=models.SET_NULL, blank=True, null=True)
    # REQUIRED_FIELDS = ['code']

    def __str__(self):
        return '%s' % (self.username,)
    
    def get_group_permission(self):
        user = CustomUser.objects.get(username=self)
        return user.groups.get()

    def roles(self):
        return dict(CustomUser.ROLE)
    
    @register.filter
    def roles_by_permission(roles_dict, user):
        if user.role=="management":
            roles_dict.pop('super')
        elif user.role=="storage_employee":
            roles_dict.pop('super')
            roles_dict.pop('management')
            roles_dict.pop('teacher')
        elif user.role=="teacher" or user.role=="student" or user.role=="student_extended":
            roles_dict = {'student': 'Oppilas'}
        return roles_dict

    @property
    def get_storage_staff(self):
        staff = CustomUser.objects.filter(storage=self.storage).filter(role='storage_employee').first()
        staff_email = staff.email if staff else ''
        return staff_email



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
    unit_name = models.CharField(max_length=25, unique=True, blank=True, null=True)
    def __str__(self):
        return '%s' % (self.unit_name)



class Goods(models.Model):
    cat_name = models.ForeignKey(Category, on_delete=models.PROTECT, blank=True, null=True)
    item_name = models.CharField(max_length=150, blank=True, null=True)
    brand = models.CharField(max_length=150, blank=True, null=True)
    model = models.CharField(max_length=150, blank=True, null=True)
    item_type = models.CharField(max_length=100, blank=True, null=True)
    size = models.CharField(max_length=50, blank=True, null=True)
    parameters = models.CharField(max_length=100, blank=True, null=True)
    contents = models.DecimalField(max_digits=11, decimal_places=4, blank=True, null=True)
    amount = IntegerRangeField(default=1, min_value=1, max_value=50, blank=True, null=True) # Jos tavaran kategori on kulutusmateriaali, käytetään amount kentä ja yksikkö
    unit = models.ForeignKey(Units, related_name='unit', on_delete=models.SET_NULL, blank=True, null=True) # Units choices moved to another table and field
    amount_x_contents = models.DecimalField(max_digits=11, decimal_places=4, blank=True, null=True)
    picture = models.ImageField(upload_to=PRODUCT_IMG_PATH, blank=True, null=True) # Make subfolders
    item_description = models.TextField(blank=True, null=True) # Kuvaus
    ean = models.CharField(max_length=13, blank=True, null=True)
    cost_centre = models.CharField(max_length=100, blank=True, null=True) # Kustannuspaikka
    purchase_data = models.DateField(blank=True, null=True) # Hankitapäivä
    purchase_price = models.DecimalField(max_digits=6, decimal_places=2, blank=True, null=True) # Hankitahinta
    purchase_place = models.CharField(max_length=50, blank=True, null=True) # Hankitapaikka
    invoice_number = models.CharField(max_length=50, blank=True, null=True) #16 Laskun numero
    storage = models.ForeignKey(Storage_name, on_delete=models.SET_NULL, blank=True, null=True)
    storage_place = models.CharField(max_length=5, blank=True, null=True)
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
    
    def get_unit(self):
        return self.unit

    @register.filter
    def modify_input(str1, val):
        # str1 = f'<input type="number" name="contents" value="3.0000" min="0" max="1000000" step="0.001" data-decimals="4" placeholder="0" readonly id="contents" data-suffix={val}>'
        new_str = str(str1)
        new_str = f"{new_str[:-1]} data-suffix={val}>"
        return new_str
    

    @property
    def decrease_items(self, is_сonsumables, amount):
        try:
            if is_сonsumables:
                self.contents -= amount
                return self.contents
            else:
                self.amount -= amount
                return self.amount
        except:
            return False

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
        if event:
            return event.estimated_date
        return None

    # This property is modificate of rentable_at 
    @property
    def is_possible_to_rent(self):
        event = Rental_event.objects.filter(item=self).filter(returned_date=None).order_by("id").first()
        if event and event.item.cat_name_id != CATEGORY_CONSUMABLES_ID:
            return [False, event.estimated_date, 'Item is not consumables but it is rented now']
        elif event and event.item.cat_name_id == CATEGORY_CONSUMABLES_ID and (event.item.amount > 0 or event.item.amount_x_contents > 0):
            return [True, event.estimated_date, 'Item are consumable and some of them are currently rented']
        elif event and event.item.cat_name_id == CATEGORY_CONSUMABLES_ID and (event.item.amount == 0 and event.item.amount_x_contents == 0):
            return [False, event.estimated_date, 'Item are consumable and storage is empty']
        return [True, None, 'Item is not rented yet']


    def __str__(self):
        return '%s' % (self.item_name)





class Rental_event(models.Model):
    item = models.ForeignKey(Goods, related_name='item', on_delete=models.SET_NULL, blank=True, null=True)
    storage = models.ForeignKey(Storage_name, on_delete=models.SET_NULL, blank=True, null=True)
    renter = models.ForeignKey(CustomUser, related_name='renter', on_delete=models.SET_NULL, blank=True, null=True)
    staff = models.ForeignKey(CustomUser, related_name='staff', on_delete=models.SET_NULL, blank=True, null=True)
    amount = models.IntegerField(blank=True, null=True)
    contents = models.DecimalField(max_digits=11, decimal_places=4, blank=True, null=True)
    units = models.ForeignKey(Units, on_delete=models.SET_NULL, blank=True, null=True) # Goods, to_field='unit',
    start_date = models.DateTimeField(blank=True, null=True)
    estimated_date = models.DateTimeField(blank=True, null=True)
    returned_date = models.DateTimeField(blank=True, null=True)
    remarks = models.CharField(max_length=255, blank=True, null=True)
    returned = models.DecimalField(max_digits=11, decimal_places=4, default=0, blank=True, null=True)

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
        return self.estimated_date > now


    # Tarkistaminen
    # This function was raplased to get_elements_by_renter and is_renter_has_not_returned_item_and_same_storage filter
    @property
    def is_user_have_non_returned_item(self):
        result = 0
        now = datetime.now()
        now = pytz.utc.localize(now)
        if self.staff.is_superuser: 
            # Kun superuser antaa lainaaksi tavara, hänellä voi olla tyhjä storage_id kenttä, siksi ei tarvitse laittaa filteriin storage=self.storage.
            # Managerilla myös voi olla tyhjä storage_id kenttä, mutta Manager ei voi antaa lainaaksi tavaroita, siksi ehdolla emme laiteta self.staff.has_perm('manager')
            event = Rental_event.objects.filter(renter=self.renter)
        else:
            event = Rental_event.objects.filter(renter=self.renter).filter(storage=self.storage)
        for e in event:
            if not e.returned_date and e.estimated_date < now: # если товар не вернули еще, и предполаг. дата больше текущей даты, то +1
                # print(e.estimated_date, now)
                result += 1
        # print (self.renter.first_name, ' - ', result)
        return result


    # get_elements_by_renter and is_renter_has_not_returned_item_and_same_storage
    # Nämä funktiot yhdessä palauttavat 1, jos henkilollä on eräntyneitä tavaroita tai 0, jos kaikki on kunnossa ja palautusaika ei ole vielä tullut
    @property
    def get_elements_by_renter(self):
        event = Rental_event.objects.filter(renter=self.renter)
        return event

    @register.filter
    def is_renter_has_not_returned_item_and_same_storage(events, staff):
        result = 0
        now = datetime.now()
        now = pytz.utc.localize(now)
        for e in events:
            # if the item has not been returned yet and the estimated date is greater than the current date, and if staff.storage has a warehouse ID and these warehouses match the rental_event or if staff.storage is empty then don't praise the warehouses.
            # ((e.storage == staff.storage and staff.storage) if staff.storage has ID then mutch storages in event and in logined user
            # (e.storage != -1 and not staff.storage) if staff.storage is empty then don't need mutch storages (equal e.storage != -1)
            if not e.returned_date and e.estimated_date < now and ((e.storage == staff.storage and staff.storage) or (e.storage != -1 and not staff.storage)): 
                result += 1
                return 1 # if at least one element is found, return 1. If comment this line we will get same result in template, but we return number of found elements or 0 if don't find nothing
        return result

    def __str__(self):
        return '%s %s %s' % (self.item, self.estimated_date, self.returned_date)



class Staff_audit(models.Model):
    staff = models.CharField(max_length=300, blank=True, null=True)
    item = models.CharField(max_length=500, blank=True, null=True)
    event_process = models.CharField(max_length=100, blank=True, null=True)
    person = models.CharField(max_length=300, blank=True, null=True)
    # We need to use related_name if we have 2 ForegnKey to same table.
    from_storage = models.CharField(max_length=100, blank=True, null=True)
    to_storage = models.CharField(max_length=100, blank=True, null=True)
    event_date = models.DateTimeField(blank=True, null=True)
    remarks = models.CharField(max_length=300, blank=True, null=True)

    def __str__(self):
         return '%s' % (self.staff)


class Settings(models.Model):
    set_name = models.CharField(max_length=150, blank=True, null=True)
    set_value = models.CharField(max_length=300, blank=True, null=True)
    label = models.CharField(max_length=300, blank=True, null=True)

    def __str__(self):
        return '%s' % (self.set_name)



class Settings_CustomUser(models.Model):
    user = models.ForeignKey(CustomUser, related_name='staff_user', blank=True, null=True, on_delete=models.CASCADE)
    setting_name = models.ForeignKey(Settings, related_name='setting_name', on_delete=models.CASCADE)
    set_value = models.CharField(max_length=300, blank=True, null=True)
    storage = models.ForeignKey(Storage_name, related_name='storage', default=None, blank=True, null=True, on_delete=models.CASCADE)


    def __str__(self):
        return self.set_value

