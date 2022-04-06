from django.shortcuts import render

import varasto



def index(request):


    return render(request, 'varasto/login.html')


def person_view(request):
    

    return render(request, 'varasto/person.html')

def user_recovery(request):


    return render(request, 'varasto/recovery.html')


def test(request):
    

    return render(request, 'varasto/test.html')

def new_item_view(request):


    return render(request, 'varasto/new_item_view.html')

def person_view(request):


    return render(request, 'varasto/person.html')

