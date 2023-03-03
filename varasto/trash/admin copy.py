from django.contrib import admin

from .models import *

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    fields = ['__ALL__']

@admin.register(Goods)
class GoodsAdmin(admin.ModelAdmin):
    fields = ['__ALL__']

@admin.register(Storage_name)
class Storage_nameAdmin(admin.ModelAdmin):
    fields = ['__ALL__']

@admin.register(Storage_place)
class Storage_placeAdmin(admin.ModelAdmin):
    fields = ['__ALL__']

@admin.register(Rental_event)
class Rental_eventAdmin(admin.ModelAdmin):
    fields = ['__ALL__']

@admin.register(Staff_event)
class Staff_eventAdmin(admin.ModelAdmin):
    fields = ['__ALL__']


# @admin.register(Employee)
# class EmployeeAdmin(admin.ModelAdmin):
#     fields = ['__ALL__']

# @admin.register(Student)
# class StudentAdmin(admin.ModelAdmin):
#     fields = ['__ALL__']


