from django import forms
from django.db import models
from .models import CustomUser, Category, Goods, Staff_event
from django.forms import DateInput, DateTimeInput, ModelForm, NumberInput, Select, widgets, TextInput, CheckboxInput


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


class GoodsForm(ModelForm):
    class Meta:
        model = Goods
        fields =['storage', 'cat_name', 'item_name', 'brand', 'model', 'item_type', 'size', 'parameters', 'package', 'picture', 'item_description', 'cost_centre', 'reg_number', 'purchase_data', 'purchase_price', 'purchase_place', 'invoice_number']
        widgets ={
            'storage': widgets.Select(attrs={
                'class': 'form-select',
            }),
            'item_name': TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Syötä nimi',
            }),
            'cat_name': widgets.Select(attrs={
                'class': 'form-select',
            }),
            'picture': widgets.FileInput(attrs={
                'class': '',
                'onchange': 'showPreview(event);'
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

class Staff_eventForm(ModelForm):
    class Meta:
        model = Staff_event
        fields = ['staff', 'item', 'from_storage', 'to_storage', 'event_date', 'amount', 'remarks']
        widgets = {
            'staff': widgets.Select(attrs={
                'class': 'form-select',
            }),
            'item': widgets.Select(attrs={
                'class': 'form-select',
            }),
            'from_storage': widgets.Select(attrs={
                'class': 'form-select',
            }),
            'to_storage': widgets.Select(attrs={
                'class': 'form-select',
            }),
            'event_date': DateInput(attrs={
                'class': 'datepicker_input form-control',
                'type': 'date',
            }),
            'amount': NumberInput(attrs={

            }),
            'remarks': TextInput(attrs={
                'class': 'form-control',
            }),

        }

