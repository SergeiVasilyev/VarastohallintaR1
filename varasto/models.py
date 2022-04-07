from django.contrib.auth.models import AbstractUser
from django.db import models
from django.contrib.auth.models import User
from django.utils.translation import gettext as _


class CustomUser(AbstractUser):
    ROLE = [
        ("student", _("Student")), # Opiskelia ei voi kirjautua ja tehdä mitään palvelussa
        ("employee", _("Employee")), # Varasto työntekiä ei voi lisätä, muokata ja posta tavaraa
        ("management", _("Management")), # Taloushallinto ei voi lainata tavara, antaa oikeuksia . Voi katsoa tapahtuma

    ]

    phone = models.CharField(max_length=15)
    code = models.CharField(max_length=10)
    photo = models.CharField(max_length=255) # Käytetään tässä URL
    role = models.CharField(choices=ROLE)



    # REQUIRED_FIELDS = ['testf']

    def __str__(self):
        return self.username



class Category(models.Model):
    catName = models.CharField(max_length=100)
    catName2 = models.CharField(max_length=100)

    def __str__(self):
        return self.catName2