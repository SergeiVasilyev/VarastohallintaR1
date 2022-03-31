from django.contrib import admin

from .models import *

#@admin.register(Recipe)

class CategoryAdmin(admin.ModelAdmin):
    fields = ['category']

# class GoodsAdmin(admin.ModelAdmin):
#     fields = ['categoryID', 'item_name', 'brand', 'model', 'item_type',
#     'size', 'parameters', 'package', 'picture', 'item_description',
#     'cost_centre', 'reg_number', 'purchase_data', 'purchase_price',
#     'purchase_place', 'invoice_number']

class GoodsAdmin(admin.ModelAdmin):
    fields = ['__ALL__']

class Storage_nameAdmin(admin.ModelAdmin):
    fields = ['storage_name']

class Storage_placeAdmin(admin.ModelAdmin):
    fields = ['itemID', 'rack', 'shelf', 'place', 'amount', 'storage_nameID']

class EmployeeAdmin(admin.ModelAdmin):
    fields = ['first_name', 'last_name', 'username', 'userpass', 'phone', 'email', 'employee_code']

class StudentAdmin(admin.ModelAdmin):
    fields = ['first_name', 'last_name', 'username', 'userpass', 'phone', 'email', 'student_code', 'photo', 'responsible_teacher']


class Rental_eventAdmin(admin.ModelAdmin):
    fields = ['studentID', 'employeeID', 'itemID', 'storageID', 'amount', 'start_date', 'estimated_date', 'returned_date', 'remarks']

class Staff_eventAdmin(admin.ModelAdmin):
    fields = ['studentID', 'employeeID', 'itemID', 'from_storage', 'to_storage', 'date', 'amount', 'remarks']


admin.site.register(Category, CategoryAdmin)
admin.site.register(Storage_name)
admin.site.register(Storage_place)
admin.site.register(Employee)
admin.site.register(Goods)
admin.site.register(Student)
admin.site.register(Rental_event)
admin.site.register(Staff_event)


