# Generated by Django 4.0.3 on 2022-09-19 17:27

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('varasto', '0035_varasto_settings_alter_rental_event_start_date'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='Varasto_Settings',
            new_name='Settings',
        ),
        migrations.AlterField(
            model_name='rental_event',
            name='start_date',
            field=models.DateTimeField(blank=True, null=True, verbose_name=datetime.datetime(2022, 9, 19, 20, 27, 42, 510532)),
        ),
    ]