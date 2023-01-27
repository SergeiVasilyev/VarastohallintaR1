from django import forms
from django.db import models
from .models import CustomUser, Category, Goods, Staff_audit, Units
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
        fields =['ean','storage', 'cat_name', 'item_name', 'brand', 
                'model', 'item_type', 'size', 'parameters', 'contents', 
                'picture', 'item_description', 'cost_centre', 'reg_number', 
                'purchase_data', 'purchase_price', 'purchase_place', 
                'invoice_number', 'amount', 'unit', 'amount_x_contents']
        widgets ={
            'ean': TextInput(attrs={
                'class': 'form-control',
                'placeholder': '',
            }),
            'storage': widgets.Select(attrs={
                'class': 'form-select',
            }),
            'item_name': TextInput(attrs={
                'class': 'form-control',
                'placeholder': '',
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
                'placeholder': '',
            }),
            'model': TextInput(attrs={
                'class': 'form-control',
                'placeholder': '',
            }),
            'item_type': TextInput(attrs={
                'class': 'form-control',
                'placeholder': '',
            }),
            'size': TextInput(attrs={
                'class': 'form-control',
                'placeholder': '',
            }),
            'contents': NumberInput(attrs={
                'min': 0, # Min value doesn't work
                'max': 1000000,
                'step': 0.001,
                'data-decimals': 4,
                'placeholder': '0',
                # 'data-suffix': model.get_unit,
            }),
            'parameters': TextInput(attrs={
                'class': 'form-control ',
                'placeholder': '',
            }),
            'item_description': widgets.Textarea(attrs={
                'class': 'form-control',
                'placeholder': '',
                'rows': '6',
            }),
            'cost_centre': TextInput(attrs={
                'class': 'form-control',
                'placeholder': '',
            }),
            'reg_number': TextInput(attrs={
                'class': 'form-control',
                'placeholder': '',
            }),
            'purchase_price': TextInput(attrs={
                'class': 'form-control',
                'placeholder': '',
            }),
            'purchase_place': TextInput(attrs={
                'class': 'form-control',
                'placeholder': '',
            }),
            'invoice_number': TextInput(attrs={
                'class': 'form-control',
                'placeholder': '',
            }),
            'amount': NumberInput(attrs={
                # 'min': 1, # Min value doesn't work
                # 'max': 100,
            }),
            'unit': widgets.Select(attrs={
                'class': 'form-select',
            }),
            'amount_x_contents': NumberInput(attrs={
                'min': 0, # Min value doesn't work
                'max': 1000000,
                'step': 1,
                'data-decimals': 4,
                'placeholder': '0',
            }),
        }

class Staff_auditForm(ModelForm):
    class Meta:
        model = Staff_audit
        fields = ['staff', 'item', 'from_storage', 'to_storage', 'event_date', 'remarks']
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
            'remarks': widgets.Textarea(attrs={
                'class': 'form-control',
                'rows': '6',
            }),

        }

