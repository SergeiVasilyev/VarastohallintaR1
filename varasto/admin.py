from django.contrib import admin

from .models import Category

from django.contrib.auth.admin import UserAdmin
from .models import User, Goods, Storage_name, Storage_place, Rental_event, Staff_event

from .models import CustomUser

from .forms import CustomUserCreationForm, CustomUserChangeForm

# staff status antaa oikeus päästä Adminpaneliin
class CustomUserAdmin(UserAdmin):
    add_form = CustomUserCreationForm
    form = CustomUserChangeForm
    model = CustomUser
    list_display = ('username', 'first_name', 'last_name', 'code', 'is_staff', 'is_active', 'role', )
    list_filter = ('is_staff', 'is_active',)
    fieldsets = (
        ('Main information', {'fields': ('username', 'password', 'first_name', 'last_name', 'group')}),
        ('Contact information', {'fields': ('email', 'phone', 'code', 'role', 'responsible_teacher', 'photo', 'last_login', 'date_joined')}),
        ('Permissions', {'fields': ('is_staff', 'is_active', 'is_superuser', 'groups', 'user_permissions')}),
    )
    add_fieldsets = (
        ('Main information', {
            'classes': ('wide', ),
            'fields': ('username', 'password1', 'password2', 'first_name', 'last_name', 'group')}
        ),
        ('Contact information', {'fields': ('email', 'phone', 'code', 'role', 'responsible_teacher', 'photo', 'last_login', 'date_joined')}),
        ('Permissions', {'fields': ('is_staff', 'is_active', 'is_superuser', 'groups', 'user_permissions')}),
    )
    list_display_links = ('username', 'first_name', 'last_name', 'code', 'role')
    search_fields = ('username', 'first_name', 'last_name',)
    ordering = ('username',)


# @admin.register(CustomUser)
# class CustomUser(admin.ModelAdmin):
#     list_display = ['username', 'password', 'first_name', 'last_name', 'phone', 'email', 'code', 'photo']

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ['cat_name']

@admin.register(Goods)
class GoodsAdmin(admin.ModelAdmin):
    list_display = ['item_name', 'brand', 'model', 'cat_name', 
        'item_type', 'size', 'parameters', 'package', 'picture',
        'item_description', 'cost_centre', 'reg_number', 'purchase_data', 
        'purchase_price', 'purchase_place', 'invoice_number', 'storage']

@admin.register(Storage_name)
class Storage_nameAdmin(admin.ModelAdmin):
    list_display = ['name', 'storage_place']

@admin.register(Storage_place)
class Storage_placeAdmin(admin.ModelAdmin):
    list_display = ['rack', 'shelf', 'place']

@admin.register(Rental_event)
class Rental_eventAdmin(admin.ModelAdmin):
    list_display = ['item', 'storage', 'renter', 'staff', 'amount', 'start_date',
        'estimated_date', 'returned_date', 'remarks']

@admin.register(Staff_event)
class Staff_eventAdmin(admin.ModelAdmin):
    list_display = ['staff', 'item', 'from_storage',
         'to_storage', 'event_date', 'amount', 'remarks']


# admin.site.register(CustomUser)
admin.site.register(CustomUser, CustomUserAdmin)


