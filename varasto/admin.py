from django.contrib import admin

from .models import Category


from django.contrib.auth.admin import UserAdmin
from .models import User


from .models import CustomUser
admin.site.register(CustomUser)

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    fields = ['catName', 'catName2']

admin.site.register(User, UserAdmin)


