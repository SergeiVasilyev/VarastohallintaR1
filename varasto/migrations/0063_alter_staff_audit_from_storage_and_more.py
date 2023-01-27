# Generated by Django 4.0.3 on 2023-01-21 18:45

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('varasto', '0062_staff_audit_delete_staff_event'),
    ]

    operations = [
        migrations.AlterField(
            model_name='staff_audit',
            name='from_storage',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='staff_audit',
            name='item',
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
        migrations.AlterField(
            model_name='staff_audit',
            name='person',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='staff_audit',
            name='staff',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='staff_audit',
            name='to_storage',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
    ]