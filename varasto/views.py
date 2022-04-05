from multiprocessing import AuthenticationError
from django.shortcuts import render
from django.shortcuts import HttpResponse, HttpResponseRedirect, render
from django.contrib.auth import authenticate





def index(request):
    # user = authenticate(username='admin', password='admin')

    # if user is not None:
    #     print('sucssess')
    # else:
    #     print('not sucssess')


    # return HttpResponse('successfully uploaded2') 
    return render(request, 'index.html')



