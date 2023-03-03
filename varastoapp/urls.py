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
from django.conf import settings
from django.conf.urls.static import static

from varasto.views import index, login_view, logout_view, recovery_view, user_recovery, rental_events, inventory
from varasto import views
from django.urls import include, re_path

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', index, name="index"),
    path('login/', login_view, name="login"),
    path('logout/', logout_view, name="logout"),
    path('recovery/', recovery_view, name="recovery"),
    path('rental_events/', views.rental_events, name='rental_events'),
    path('rental_events_goods/', views.rental_events_goods, name='rental_events_goods'),
    path('set_rental_event_view/', views.set_rental_event_view, name='set_rental_event_view'),
    path('set_ordering/', views.set_ordering, name='set_ordering'),
    path('set_order_field/', views.set_order_field, name='set_order_field'),

    path('base_main/', views.base_main, name='base_main'),

    path('renter/<int:idx>/', views.renter, name='renter'),
    path('product/<int:idx>/', views.product, name='product'),
    path('product_barcode/<int:idx>/', views.product_barcode, name='product_barcode'),
    path('product_barcode_ean13/<int:idx>/', views.product_barcode_ean13, name='product_barcode_ean13'),
    path('new_event/', views.new_event, name='new_event'),
    # path('new_event/add_user_to_event/', views.add_user_to_event, name='add_user_to_event'),
    # re_path(r'.*/add_user_to_event/', views.add_user_to_event, name='add_user_to_event'),



    path('recovery/', views.user_recovery, name='recovery'),
    path('new_item/', views.new_item, name='new_item'),
    path('edit_item/<int:idx>/', views.edit_item, name='edit_item'),
    path('delete_product/<int:idx>/', views.delete_product, name='delete_product'),


    path('new_event_goods/', views.new_event_goods, name='new_event_goods'),
    path('inventory/', views.inventory, name='inventory'),
    path('report/<int:idx>/', views.report, name='report'),
    path('product_report/<int:idx>/', views.product_report, name='product_report'),

    path('test/', views.test, name='test'),

    path('new_user/', views.new_user, name='new_user'),
    path('grant_permissions/', views.grant_permissions, name='grant_permissions'),
    path('storage_settings/', views.storage_settings, name='storage_settings'),
    # path('video_stream', views.video_stream, name='video_stream'),
    # path('new_item/take_pacture', views.take_pacture, name='take_pacture'),
    path('products/', views.products, name='products'),
    path('get_products/', views.getProducts, name='getProducts'),
    path('get_photo/', views.get_photo, name='get_photo'),
    path('get_persons/', views.getPersons, name='getPersons'),
    path('get_product/', views.getProduct, name='getProduct'),
    path('get_product2/', views.getProduct2, name='getProduct2'),
    path('save_permision/<int:idx>/', views.save_permision, name='save_permision'),
    path('burger_settings/', views.burger_settings, name='burger_settings'),
    path('initilize/', views.initilize, name='initilize'),

    path('filling_goods_description/', views.filling_goods_description, name='filling_goods_description'),

] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

