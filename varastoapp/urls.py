"""varastoapp URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from django.contrib import admin
from django.urls import path

from varasto.views import index, login_view, logout_view, recovery_view, user_recovery, test, person_view, rental_events
from varasto import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', index, name="index"),
    path('login/', login_view, name="login"),
    path('logout/', logout_view, name="logout"),
    path('recovery/', recovery_view, name="recovery"),
    path('rental_events/', views.rental_events, name='rental_events'),
    path('base_main/', views.base_main, name='base_main'),
    path('new_event/', views.new_event, name='new_event'),

    path('dict_question/', views.dict_question, name='dict_question'),
    path('person/', views.person_view, name='person'),
    path('test/', views.test, name='test'),
    path('recovery/', views.user_recovery, name='recovery'),
    path('new_item/', views.new_item, name='new_item'),
    path('update_rental_status/', views.update_rental_status, name='update_rental_status'),
    path('test_Anna/', views.test_Anna_view, name='test_Anna'),
    path('new_event_goods/', views.new_event_goods, name='new_event_goods'),
]
