from enum import unique
from django.conf import Settings
from django.contrib.auth.models import User
from django.db import models

class Category(models.Model):
    category = models.CharField(max_length=20)

    def __str__(self):
         return '%s' % (self.category)

class Goods(models.Model):
    categoryID = models.ForeignKey(Category, on_delete=models.CASCADE, blank=True, null=True)
    item_name = models.CharField(max_length=20)
    brand = models.CharField(max_length=20)
    model = models.CharField(max_length=20)
    item_type = models.CharField(max_length=20)
    size = models.CharField(max_length=20)
    parameters = models.CharField(max_length=20)
    package = models.CharField(max_length=20)
    picture = models.CharField(max_length=20)
    item_description = models.CharField(max_length=20)
    cost_centre = models.CharField(max_length=20)
    reg_number = models.CharField(max_length=20)
    purchase_data = models.DateField()
    purchase_price = models.DecimalField(max_digits=6, decimal_places=2)
    purchase_place = models.CharField(max_length=20)
    invoice_number = models.CharField(max_length=20) #16

    def __str__(self):
         return '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s' % (self.categoryID, self.item_name, self.brand, 
         self.model, self.item_type, self.size, self.parameters, self.package, self.picture,
         self.item_description, self.cost_centre, self.reg_number, self.purchase_data, self.purchase_price, self.purchase_place, self.invoice_number)



class Storage_name(models.Model):
    storage_name = models.CharField(max_length=30)

    def __str__(self):
         return '%s' % (self.storage_name)


class Storage_place(models.Model):
    itemID = models.ForeignKey(Goods, on_delete=models.CASCADE, blank=True, null=True)
    rack = models.CharField(max_length=20)
    shelf = models.CharField(max_length=20)
    place = models.CharField(max_length=20)
    amount = models.CharField(max_length=30) #????
    storage_nameID = models.ForeignKey(Storage_name, on_delete=models.CASCADE, blank=True, null=True)

    def __str__(self):
         return '%s %s %s %s %s %s' % (self.itemID, self.rack, self.shelf, self.place, self.amount, self.storage_nameID)



class Employee(models.Model):
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    username = models.CharField(max_length=20)
    userpass = models.CharField(max_length=20)
    phone = models.CharField(max_length=20)
    email = models.CharField(max_length=30)
    employee_code = models.IntegerField

    def __str__(self):
         return '%s %s %s %s %s %s %s' % (self.first_name, self.last_name, self.username, self.userpass, self.phone, self.email, self.employee_code)


class Student(models.Model):
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    username = models.CharField(max_length=20)
    userpass = models.CharField(max_length=20)
    phone = models.CharField(max_length=20)
    email = models.CharField(max_length=30)
    student_code = models.CharField(max_length=20)
    photo = models.CharField(max_length=20)
    # responsible_teacher = models.ForeignKey(Employee, on_delete=models.CASCADE, blank=True, null=True)
    responsible_teacher = models.ForeignKey(User, on_delete=models.CASCADE, blank=True, null=True) #!!!!!!!!!!!!!

    def __str__(self):
         return '%s %s %s %s %s %s %s %s %s' % (self.first_name, self.last_name, self.username, self.userpass,
         self.phone, self.email, self.student_code, self.photo, self.responsible_teacher)


class Rental_event(models.Model):
    # Jos oppilas poistetaan, pitäisikös oppilas ja hänen tietonsa ja lainauksensa tallentaa?
    # studentID = models.ForeignKey(Student, on_delete=models.CASCADE, blank=True, null=True)
    renter = models.ForeignKey(User, on_delete=models.CASCADE, blank=True, null=True) #!!!!!!!!!!!!!
    # Jos employee poistetaan, pitäisikös oppilas ja hänen tietonsa ja lainauksensa tallentaa? 
    # employeeID = models.ForeignKey(Employee, on_delete=models.CASCADE, blank=True, null=True)
    itemID = models.ForeignKey(Goods,  on_delete=models.CASCADE, blank=True, null=True)
    storageID = models.ForeignKey(Storage_place, on_delete=models.CASCADE, blank=True, null=True)
    amount = models.IntegerField
    start_date = models.DateTimeField
    estimated_date = models.DateTimeField
    returned_date = models.DateTimeField
    remarks = models.CharField(max_length=255)

    def __str__(self):
         return '%s %s %s %s %s %s %s %s %s' % (self.renter, self.amount, self.start_date,
         self.estimated_date, self.returned_date, self.remarks)


class Staff_event(models.Model):
    # employeeID = models.ForeignKey(Employee,  on_delete=models.CASCADE, blank=True, null=True)
    # studentID = models.ForeignKey(Student,  on_delete=models.CASCADE, blank=True, null=True)
    staff = models.ForeignKey(User, on_delete=models.CASCADE, blank=True, null=True) #!!!!!!!!!!!!!
    itemID = models.ForeignKey(Goods,  on_delete=models.CASCADE, blank=True, null=True)
    # We need to use related_name if we have 2 ForegnKey to same table.
    from_storage = models.ForeignKey(Storage_place, related_name='from_storage', on_delete=models.CASCADE, blank=True, null=True)
    to_storage = models.ForeignKey(Storage_place, related_name='to_storage', on_delete=models.CASCADE, blank=True, null=True)
    date = models.DateField
    amount = models.IntegerField
    remarks = models.CharField(max_length=100)

    def __str__(self):
         return '%s %s %s %s %s %s %s %s' % (self.staff, self.itemID, self.from_storage,
         self.to_storage, self.date, self.amount, self.remarks)

