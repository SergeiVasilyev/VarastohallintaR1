from django.http import (
    HttpResponse,
    HttpResponseBadRequest,
    HttpResponseNotFound,
)
from django.shortcuts import redirect, render
from django.contrib.auth import authenticate, login, logout
from .forms import CustomUserForm


def login_view(request):
    if not request.user.is_authenticated:
        if request.method == 'POST':
            username = request.POST['username']
            password = request.POST['password']
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)
                print('sucsess')
                return redirect('index')
            else:
                print('error')
                return HttpResponse("<html><body><h1>error</h1></body></html>")
        else:
            form = CustomUserForm()
            context = {'form': form}
            return render(request, 'varasto/login.html', context)
    else:
        return redirect('index')

def logout_view(request):
    logout(request)
    return redirect('login')

def recovery_view(request):
    return render(request, 'varasto/recovery.html')

def index(request):
    if not request.user.is_authenticated:
        return redirect('login')
    return render(request, 'varasto/index.html')





def user_recovery(request):
    return render(request, 'varasto/recovery.html')

def test(request):
    return render(request, 'varasto/test.html')

def new_item_view(request):
    return render(request, 'varasto/new_item_view.html')

def person_view(request):
    return render(request, 'varasto/person.html')








