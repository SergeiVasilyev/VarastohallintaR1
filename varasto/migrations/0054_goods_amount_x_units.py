# Generated by Django 4.0.3 on 2022-11-25 10:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('varasto', '0053_alter_rental_event_units_alter_units_unit_name'),
    ]

    operations = [
        migrations.AddField(
            model_name='goods',
            name='amount_x_units',
            field=models.DecimalField(blank=True, decimal_places=4, max_digits=11, null=True),
        ),
    ]