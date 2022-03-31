from django.shortcuts import render
from django.shortcuts import HttpResponse, HttpResponseRedirect, render

def index(request):
    return HttpResponse('successfully uploaded2') 
