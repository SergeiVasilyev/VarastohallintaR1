# Generated by Django 4.0.3 on 2022-05-16 05:44

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('varasto', '0026_alter_category_cat_name_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='goods',
            name='item_status',
            field=models.CharField(blank=True, choices=[('available', 'saatavilla'), ('not_available', 'ei saatavilla'), ('under_repair', 'korjaamassa')], max_length=50, null=True),
        ),
        migrations.AlterField(
            model_name='rental_event',
            name='start_date',
            field=models.DateTimeField(blank=True, null=True, verbose_name=datetime.datetime(2022, 5, 16, 8, 44, 29, 188286)),
        ),
    ]
