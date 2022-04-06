from django import forms
from django.db import models
from .models import CustomUser, Category
from django.forms import ModelForm, widgets, TextInput, CheckboxInput



class CustomUserForm(ModelForm):
    class Meta:
        model = CustomUser
        fields = ['username', 'password']
        widgets = {
            'username': TextInput(attrs={
                'class': 'form-control left',
                'placeholder': 'login',
            }),
            'password': TextInput(attrs={
                'class': 'form-control left',
                'placeholder': 'password',
            }),

        }

