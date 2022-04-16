from multiprocessing import context
import operator
from turtle import update
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
from .models import User, Goods, Storage_name, Storage_place, Rental_event, Staff_event, CustomUser
from django.db.models import Count


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


# @user_passes_test(user_check, redirect_field_name=None)
@login_required()
@user_passes_test(is_not_student, redirect_field_name=None)
def main_page(request):
    # rental_events = Rental_event.objects.all().order_by('renter', 'start_date')
    # rental_events = Rental_event.objects.all().order_by('start_date')
    # query_set = Rental_event.objects.select_related('renter').filter(returned_date__isnull=True).order_by('start_date')
    query_set = Rental_event.objects.filter(returned_date__isnull=True).order_by('renter', 'start_date')
    # print(query_set)
    for i in query_set:
        print(i.renter, i.item)


    now = datetime.now()
    datenow = now.strftime("%d.%m.%Y")
    context = {
        
        'rental_events': query_set,
        'datenow': datenow,
        'user': request.user
    }

    return render(request, 'varasto/main_page.html', context)











def dict_question(request):

    query_set = Rental_event.objects.filter(returned_date__isnull=True).order_by('start_date')
    # print(query_set)
    # for i in query_set:
    #     print(i.renter, i.item)
    # newlist = {}
    # for i in query_set:
    #     if not i.returned_date:
    #         if i.renter.username in newlist:
    #             newlist[i.renter.username] += [i.item, i.renter, i.start_date]
    #         else:
    #             newlist[i.renter.username] = [i.item, i.renter, i.start_date]         
    
    newlist = {
        'first': ['one', 'two'],
        'second': ['three', 'four'],
        'third': {'fifth': ['five', 'six'], 'seventh': 'SEVEN'}
    }

    print(newlist)
    print(newlist['third']['fifth'][1])

    context = {
        'rental_events': newlist,
    }
    return render(request, 'varasto/question.html', context)   








# @login_required()
# @user_passes_test(is_not_student, redirect_field_name=None)
# def main_page(request):
#     # rental_events = Rental_event.objects.all().order_by('renter', 'start_date')
#     # rental_events = Rental_event.objects.all().order_by('start_date')
#     # query_set = Rental_event.objects.select_related('renter').filter(returned_date__isnull=True).order_by('start_date')
    
#     # arch = {}
#     # for a in Rental_event.objects.filter(returned_date__isnull=True).order_by('start_date'):
#     #     print(a.start_date)
#     #     usernameq = arch.get(a.renter.username, {})
#     #     date = usernameq.get(a.start_date, [])
#     #     date.append(a)
#     #     usernameq[a.renter.username] = date
#     #     arch[a.renter.username] = usernameq

#     # print(arch)
#     query_set = Rental_event.objects.select_related('renter', 'item').filter(returned_date__isnull=True).annotate(total_count=Count('start_date')).order_by('start_date')
#     # print(query_set)
#     for i in query_set:
#         print(i.renter, i.item)

#     newlist = {
#         'first': ['one', 'two'],
#         'second': ['three', 'four'],
#     }
#     # for i in query_set:
#     #     if not i.returned_date:
#     #         if i.renter.username in newlist:
#     #             newlist[i.renter.username] = newlist[i.renter.username] + [i.item] + [i.renter]
#     #             # newlist[i.renter.username] += [i.item, i.renter, i.start_date, i.estimated_date, i.returned_date, i.renter.id]
#     #         else:
#     #             newlist[i.renter.username] = [i.item]
#     #             # newlist[i.renter.username] = [i.item, i.renter, i.start_date, i.estimated_date, i.returned_date, i.renter.id]
                
#     print(newlist)
#     # print(newlist['user6'][0].brand)
#     # print(newlist['user6'][1].first_name)
#     # print(newlist['user6'][2])
#     # print(newlist['user6'][3])
#     # print(newlist['user6'][4])

#     # for event in newlist:
#     #     for x, item in enumerate(newlist[event]):
#     #         print(newlist[event][0].brand)


#     now = datetime.now()
#     datenow = now.strftime("%d.%m.%Y")
#     context = {
        
#         'rental_events': newlist,
#         'datenow': datenow,
#         'user': request.user
#     }

#     return render(request, 'varasto/main_page.html', context)

# # @user_passes_test(user_check, redirect_field_name=None)
# @login_required()
# @user_passes_test(is_not_student, redirect_field_name=None)
# def main_page(request):
#     # rental_events = Rental_event.objects.all().order_by('renter', 'start_date')
#     rental_events = Rental_event.objects.all().order_by('start_date')
#     # t = Rental_event.objects.get(id=2)
#     # r = t.renter.last_name
#     newlist = {}
#     for i in rental_events:
#         if not i.returned_date:
#             if i.renter.username in newlist:
#                 newlist[i.renter.id] += [i.item, i.renter, i.start_date, i.estimated_date, i.id]
#             else:
#                 newlist[i.renter.id] = [i.item, i.renter, i.start_date, i.estimated_date, i.id]

#     for x in newlist[7]:
#         print(x)
#     print(newlist)


#     # for item, amount in newlist.items():  # dct.iteritems() in Python 2
#     #     print("{} ({})".format(item, amount))


#     # db_sorted = sorted(newlist, key=lambda row: (row['start_date']))
#     # print(db_sorted)
#     # test = rental_events[0]
#     # r = test.renter.code
#     # print(r)
#         # print(i.renter.last_name)
#     # print(rental_events.values('renter_id'))
#     # print(newlist['user1'])
#     now = datetime.now()
#     datenow = now.strftime("%d.%m.%Y")
#     context = {
#         'newlist': newlist, # теперь можно перебрать массив по имени, а данные уже отсортированы по дате
#         'rental_events': newlist,
#         'datenow': datenow,
#         'user': request.user
#     }

#     return render(request, 'varasto/main_page.html', context)



