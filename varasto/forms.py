from django import forms
from django.db import models
from .models import CustomUser, Category
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

