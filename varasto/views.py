from multiprocessing import context
from django.http import (
    HttpResponse,
    HttpResponseBadRequest,
    HttpResponseNotFound,
)
from django.shortcuts import redirect, render
from django.contrib.auth import authenticate, login, logout
from .forms import CustomUserForm
from .checkUser import *
from django.contrib.auth.decorators import login_required
from django.contrib.auth.decorators import user_passes_test
from datetime import datetime


def login_view(request):
    if not request.user.is_authenticated:
        if request.method == 'POST':
            username = request.POST['username']
            password = request.POST['password']
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)
                print('sucsess')
                if user_check(user) and is_not_student(user):
                    return redirect('main_page')
                else:
                    return HttpResponse("<html><body><h1>Ei ole okeuksia päästä tähän sivuun</h1></body></html>") # Tässä voimme tehdä Timer, 10 sec jälkeen tehdään LOGOUT
            else:
                # Pitää rakentaa frontendilla vastaus, että kirjoitettu salasana tai tunnus oli väärin
                return redirect('login')
                # return HttpResponse("<html><body><h1>error</h1></body></html>")
        else:
            form = CustomUserForm()
            context = {'form': form}
            return render(request, 'varasto/login.html', context)
    else:
        if user_check(request.user) and is_not_student(request.user):
            return redirect('main_page')
        else:
            return HttpResponse("<html><body><h1>Ei ole okeuksia päästä tähän sivuun</h1></body></html>") # Tässä voimme tehdä Timer, 10 sec jälkeen tehdään LOGOUT


def logout_view(request):
    logout(request)
    return redirect('login')

def recovery_view(request):
    if request.user.is_authenticated:
        return redirect('login')
    return render(request, 'varasto/recovery.html')

def index(request):
    if not request.user.is_authenticated:
        return redirect('login')
    return render(request, 'varasto/index.html')



def new_item(request):
    return render(request, 'varasto/new_item.html')

def user_recovery(request):
    return render(request, 'varasto/recovery.html')

def test(request):
    return render(request, 'varasto/test.html')

def new_item_view(request):
    return render(request, 'varasto/new_item_view.html')

def person_view(request):
    return render(request, 'varasto/person.html')

def menu_view(request):
    return render(request, 'varasto/menu.html')

def main_base_view(request):
    return render(request, 'varasto/main_base.html')


def test_Anna_view(request):
    return render(request, 'varasto/test_Anna.html')

# @user_passes_test(user_check, redirect_field_name=None)
@login_required()
@user_passes_test(is_not_student, redirect_field_name=None)
def main_page(request):
    now = datetime.now()
    datenow = now.strftime("%d.%m.%Y")
    context = {
        'datenow': datenow,
        'user': request.user
    }

    return render(request, 'varasto/main_page.html', context)




