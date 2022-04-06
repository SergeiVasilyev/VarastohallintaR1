from django.shortcuts import render

import varasto



def index(request):


    return render(request, 'varasto/login.html')


def person_view(request):
    

    return render(request, 'varasto/person.html')



def test(request):
    

    return render(request, 'varasto/test.html')

