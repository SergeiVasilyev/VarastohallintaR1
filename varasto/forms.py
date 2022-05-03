from django import forms
from django.db import models
from .models import CustomUser, Category, Goods
from django.forms import ModelForm, widgets, TextInput, CheckboxInput


from django.contrib.auth.forms import UserCreationForm, UserChangeForm



class CustomUserCreationForm(UserCreationForm):
    class Meta(UserCreationForm):
        model = CustomUser
        fields = ('username', 'password')
        # widgets = {
        #     'password': TextInput(attrs={
        #         'placeholder': 'password',
        #         'type': "password",
        #     })
        # }

class CustomUserChangeForm(UserChangeForm):
    class Meta:
        model = CustomUser
        fields = ('username', 'password')
        # widgets = {
        #     'password': TextInput(attrs={
        #         'placeholder': 'password',
        #         'type': "password",
        #     })
        # }


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
                'type': "password",
            }),

        }

class AddItemForm(ModelForm):
    class Meta:
        model = Goods
        fields =['cat_name', 'item_name', 'brand', 'model', 'item_type', 'size', 'parameters', 'package', 'picture', 'item_description', 'cost_centre', 'reg_number', 'purchase_data', 'purchase_price', 'purchase_place', 'invoice_number']
        widgets ={
            'item_name': TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Syötä nimi',
            }),
            'cat_name': widgets.Select(attrs={
                'class': 'form-select',
                'placeholder': 'Syötä nimi',
            }),
            'picture': widgets.FileInput(attrs={
                'class': '',
            }),
            'purchase_data': TextInput(attrs={
                'class': 'datepicker_input form-control',
                'type': 'date',
            }),
            'brand': TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Syötä merkki',
            }),
            'model': TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Syötä malli',
            }),
            'item_type': TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Syötä tyyppi',
            }),
            'size': TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Syötä koko',
            }),
            'package': TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Syötä pakkaus',
            }),
            'parameters': TextInput(attrs={
                'class': 'form-control ',
                'placeholder': 'Syötä tekniset parametrit/tiedot',
            }),
            'item_description': widgets.Textarea(attrs={
                'class': 'form-control',
                'placeholder': 'Syötä lisätiedot',
            }),
            'cost_centre': TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Syötä kustannuspaikka',
            }),
            'reg_number': TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Syötä rekisterinumero',
            }),
            'purchase_price': TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Syötä hankintahinta',
            }),
            'purchase_place': TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Syötä hankintapaikka',
            }),
            'invoice_number': TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Syötä laskunr',
            }),

        
        }

