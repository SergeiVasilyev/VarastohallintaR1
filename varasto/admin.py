from django.contrib import admin

from .models import Category

from django.contrib.auth.admin import UserAdmin
from .models import User, Goods, Storage_name, Storage_place, Rental_event, Staff_audit, Settings, Units

from .models import CustomUser

from .forms import CustomUserCreationForm, CustomUserChangeForm

# staff status antaa oikeus päästä Adminpaneliin
class CustomUserAdmin(UserAdmin):
    add_form = CustomUserCreationForm
    form = CustomUserChangeForm
    model = CustomUser
    list_display = ('username', 'first_name', 'last_name', 'code', 'is_storage_staff', 'is_staff', 'is_active', 'role', 'storage')
    list_filter = ('is_storage_staff', 'is_staff', 'is_active',)
    fieldsets = (
        ('Main information', {'fields': ('username', 'password', 'first_name', 'last_name', 'group', 'storage')}),
        ('Contact information', {'fields': ('email', 'phone', 'code', 'role', 'responsible_teacher', 'photo', 'last_login', 'date_joined')}),
        ('Permissions', {'fields': ('is_storage_staff', 'is_staff', 'is_active', 'is_superuser', 'groups', 'user_permissions')}),
    )
    add_fieldsets = (
        ('Main information', {
            'classes': ('wide', ),
            'fields': ('username', 'password1', 'password2', 'first_name', 'last_name', 'group', 'storage')}
        ),
        ('Contact information', {'fields': ('email', 'phone', 'code', 'role', 'responsible_teacher', 'photo', 'last_login', 'date_joined')}),
        ('Permissions', {'fields': ('is_storage_staff','is_staff', 'is_active', 'is_superuser', 'groups', 'user_permissions')}),
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
        'item_type', 'size', 'parameters', 'contents', 'picture',
        'item_description', 'cost_centre', 'purchase_data', 
        'purchase_price', 'purchase_place', 'invoice_number', 'storage', 'ean', 'amount', 'unit', 'amount_x_contents']

@admin.register(Storage_name)
class Storage_nameAdmin(admin.ModelAdmin):
    list_display = ['name', 'storage_code']

@admin.register(Storage_place)
class Storage_placeAdmin(admin.ModelAdmin):
    list_display = ['rack', 'shelf', 'place']

@admin.register(Rental_event)
class Rental_eventAdmin(admin.ModelAdmin):
    list_display = ['item', 'storage', 'renter', 'staff', 'amount', 'start_date',
        'estimated_date', 'returned_date', 'remarks']

@admin.register(Staff_audit)
class Staff_auditAdmin(admin.ModelAdmin):
    list_display = ['staff', 'item', 'from_storage',
         'to_storage', 'event_date', 'remarks']

@admin.register(Settings)
class Storage_nameAdmin(admin.ModelAdmin):
    list_display = ['set_name', 'set_value']

@admin.register(Units)
class Storage_nameAdmin(admin.ModelAdmin):
    list_display = ['id', 'unit_name']

# admin.site.register(CustomUser)
admin.site.register(CustomUser, CustomUserAdmin)


