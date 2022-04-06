from django.contrib.auth.models import AbstractUser
from django.db import models
from django.contrib.auth.models import User


class CustomUser(AbstractUser):
    testf = models.CharField(max_length=100)
    # REQUIRED_FIELDS = ['testf']

    def __str__(self):
        return self.username



class Category(models.Model):
    catName = models.CharField(max_length=100)
    catName2 = models.CharField(max_length=100)

    def __str__(self):
        return self.catName2