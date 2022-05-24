from datetime import datetime
from django.contrib.auth.models import AbstractUser, User
from django.db import models
from django.utils.translation import gettext as _
import pytz
from django.template.defaulttags import register



class CustomUser(AbstractUser):
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

    # REQUIRED_FIELDS = ['code']

    def __str__(self):
        return '%s' % (self.username,)
        # return '%s %s %s %s %s %s %s %s' % (self.first_name, self.last_name, self.username, self.password,
        # self.phone, self.email, self.code, self.photo)

# Сделать три таблицы места, где будут сделаны константы RACK = [A, B, C...], SHELF[0-9], PLACE[0-20]
# Из Storage_place на них будет ссылка, а также ссылка на Storage_name !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

# Tietäkö työntekija tavaran paikka kun hän lisää uusi tavara? 
# Нужно добавить Foreign key на Storage в Goods
class Storage_place(models.Model):
    rack = models.CharField(max_length=20, blank=True, null=True) # Voi olla työntekija, joilla on oikeuksia lisätä tavara ei tiedä paikan numero
    shelf = models.CharField(max_length=20, blank=True, null=True)
    place = models.CharField(max_length=20, blank=True, null=True)
    def __str__(self):
        return '%s %s %s %s %s %s' % (self.rack, self.shelf, self.place)

class Storage_name(models.Model):
    name = models.CharField(max_length=30)
    storage_place = models.ForeignKey(Storage_place, on_delete=models.PROTECT, blank=True, null=True)

    def __str__(self):
        return '%s' % (self.name)


class Category(models.Model):
    cat_name = models.CharField(max_length=100)

    def __str__(self):
        return '%s' % (self.cat_name)

class Goods(models.Model):
    UNITS = [
        ("unit", _("kpl")),
        ("litre", _("l")),
        ("kilogram", _("kg")),
    ]
    ITEM_STATUS = [
        ("available", _("saatavilla")),
        ("not_available", _("ei saatavilla")),
        ("under_repair", _("korjaamassa")),
    ]
    cat_name = models.ForeignKey(Category, on_delete=models.PROTECT, blank=True, null=True)
    item_name = models.CharField(max_length=150, blank=True, null=True)
    brand = models.CharField(max_length=150, blank=True, null=True)
    model = models.CharField(max_length=150, blank=True, null=True)
    item_type = models.CharField(max_length=100, blank=True, null=True)
    size = models.CharField(max_length=50, blank=True, null=True)
    parameters = models.CharField(max_length=100, blank=True, null=True)
    pack = models.CharField(max_length=50, blank=True, null=True) # 
    amount = models.PositiveIntegerField(default=1, blank=True, null=True) # Jos tavaran kategori on kulutusmateriaali, käytetään amount kentä ja yksikkö
    units = models.CharField(max_length=50, choices=UNITS, default='unit', blank=True, null=True) # Jos tavaran kategori on kulutusmateriaali, käytetään amount kentä ja yksikkö
    picture = models.ImageField(upload_to='images/goods/', blank=True, null=True) # Сделать подпапки
    item_description = models.CharField(max_length=255, blank=True, null=True) # Kuvaus
    ean = models.CharField(max_length=50, null=True)
    cost_centre = models.CharField(max_length=100, blank=True, null=True) # Kustannuspaikka
    reg_number = models.CharField(max_length=50, blank=True, null=True) # ??? - poistetaan
    purchase_data = models.DateField(blank=True, null=True) # Hankitapäivä
    purchase_price = models.DecimalField(max_digits=6, decimal_places=2, blank=True, null=True) # Hankitahinta
    purchase_place = models.CharField(max_length=50, blank=True, null=True) # Hankitapaikka
    invoice_number = models.CharField(max_length=50, blank=True, null=True) #16 Laskun numero
    storage = models.ForeignKey(Storage_name, on_delete=models.PROTECT, blank=True, null=True)
    item_status = models.CharField(max_length=50, choices=ITEM_STATUS, blank=True, null=True)

    @property
    def rentable_at(self):
        rental_events = Rental_event.objects.all().order_by("item")
        event = rental_events.filter(item=self).first()
        # event = Rental_event.objects.filter(item=self).order_by("id").first()
        # print(self.id, event)
        if event:
            return event.estimated_date
        return None


    def __str__(self):
        return '%s' % (self.item_name)
        # return '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s' % (self.cat_name, self.item_name, self.brand, 
        # self.model, self.item_type, self.size, self.parameters, self.package, self.picture,
        # self.item_description, self.cost_centre, self.reg_number, self.purchase_data, self.purchase_price, self.purchase_place, self.invoice_number)





class Rental_event(models.Model):
    item = models.ForeignKey(Goods, related_name='item', on_delete=models.PROTECT)
    storage = models.ForeignKey(Storage_place, on_delete=models.PROTECT, blank=True, null=True)
    renter = models.ForeignKey(CustomUser, related_name='renter', on_delete=models.PROTECT)
    staff = models.ForeignKey(CustomUser, related_name='staff', on_delete=models.PROTECT)
    amount = models.IntegerField # Ei tarvitse, koska lainaamisella käytetään Yksi Unikki Tuote
    start_date = models.DateTimeField(datetime.now(), blank=True, null=True)
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


