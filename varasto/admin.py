from django.contrib import admin

from .models import *

#@admin.register(Recipe)

class CategoryAdmin(admin.ModelAdmin):
    fields = ['__ALL__']

class GoodsAdmin(admin.ModelAdmin):
    fields = ['__ALL__']

class Storage_nameAdmin(admin.ModelAdmin):
    fields = ['__ALL__']

class Storage_placeAdmin(admin.ModelAdmin):
    fields = ['__ALL__']

# class EmployeeAdmin(admin.ModelAdmin):
#     fields = ['__ALL__']

# class StudentAdmin(admin.ModelAdmin):
#     fields = ['__ALL__']

class Rental_eventAdmin(admin.ModelAdmin):
    fields = ['__ALL__']

class Staff_eventAdmin(admin.ModelAdmin):
    fields = ['__ALL__']


admin.site.register(Category, CategoryAdmin)
admin.site.register(Storage_name)
admin.site.register(Storage_place)
# admin.site.register(Employee)
admin.site.register(Goods)
# admin.site.register(Student)
admin.site.register(Rental_event)
admin.site.register(Staff_event)


