from django.shortcuts import render

import varasto



def index(request):


    return render(request, 'varasto/index.html')


