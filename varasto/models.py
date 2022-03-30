from enum import unique
from django.db import models

class Storage_name(models.Model):
    storage_nameID = models.Model(primary_key=True)
    storage_name = models.CharField(max_length=30)


class Storage_place(models.Model):
    storageID = models.Model(primary_key=True)
    itemID = models.CharField(max_length=30)
    rack = models.CharField(max_length=20)
    shelf = models.CharField(max_length=20)
    Place = models.CharField(max_length=20)
    amount = models.CharField(max_length=30)
    storage_nameID = models.ForeignKey(Storage_name, on_delete=models.CASCADE,blank=True)


class Employee(models.Model):
    emplyeeID = models.Model(primary_key=True)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    login = models.CharField(max_length=20)
    password = models.CharField(max_length=20)
    phone = models.CharField(max_length=20)
    email = models.CharField(max_length=30)
    employee_code = models.IntegerField(max_length=20)


class Student(models.Model):
    studentID = models.Model(primary_key=True)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    login = models.CharField(max_length=20)
    password = models.CharField(max_length=20)
    phone = models.CharField(max_length=20)
    email = models.CharField(max_length=30)
    student_code = models.CharField(max_length=20)
    photo = models.CharField(max_length=20)
    employee = models.CharField(max_length=20)


class Category(models.Model):
    categoryID = models.Model(Primarykey=True)
    category = models.CharField(max_length=20)


class Goods(models.Model):
    itemID = models.Model(primary_key=True)
    categoryID = models.ForeignKey(Category, on_delete=models.CASCADE,blank=True)
    name = models.CharField(max_length=20)
    brand = models.CharField(max_length=20)
    model = models.CharField(max_length=20)
    type = models.CharField(max_length=20)
    size = models.CharField(max_length=20)
    parameters = models.CharField(max_length=20)
    package = models.CharField(max_length=20)
    picture = models.CharField(max_length=20)
    description = models.CharField(max_length=20)
    cost_centre = models.CharField(max_length=20)
    reg_number = models.CharField(max_length=20)
    purchase_year = models.CharField(max_length=20)
    purchase_price = models.Model
    purchase_place = models.CharField(max_length=20)
    invoice_number = models.CharField(max_length=20)
    storageID = models.ForeignKey(Storage_place, on_delete=models.CASCADE,blank=True)


class Rental_event(models.Model):
    rental_eventID = models.Model(Primary_key=True)
    # Jos oppilas poistetaan, pitäisikös oppilas ja hänen tietonsa ja lainauksensa tallentaa?
    studentID = models.ForeignKey(Student, on_delete=models.CASCADE,blank=True)
    # Jos employee poistetaan, pitäisikös oppilas ja hänen tietonsa ja lainauksensa tallentaa? 
    employeeID = models.ForeignKey(Employee, on_delete=models.CASCADE,blank=True)
    itemID = models.ForeignKey(Goods, on_delete=models.CASCADE,blank=True)
    storageID = models.ForeignKey(Storage_place, on_delete=models.CASCADE,blank=True)
    amount = models.IntegerField
    start_date = models.DateTimeField
    estimated_date = models.DateTimeField
    returned_date = models.DateTimeField
    remarks = models.CharField(max_length=100)


class Staff_event(models.Model):
    Staff_eventID = models.Model(Primarykey=True)
    EmployeeID = models.ForeignKey(Employee, on_delete=models.CASCADE,blank=True)
    StudentID = models.ForeignKey(Student, on_delete=models.CASCADE,blank=True)
    itemID = models.ForeignKey(Goods, on_delete=models.CASCADE,blank=True)
    from_storage = models.ForeignKey(Storage_place, on_delete=models.CASCADE,blank=True)
    to_storage = models.ForeignKey(Storage_place, on_delete=models.CASCADE,blank=True)
    date = models.DateField
    amount = models.IntegerField
    remarks = models.CharField(max_length=100)

class product_group(models.Model):
    product_groupID = models.Model(Primarykey=True)
    itemID = models.ForeignKey(Storage_place, on_delete=models.CASCADE,blank=True)
    group_str = models.Model(str, unique)  