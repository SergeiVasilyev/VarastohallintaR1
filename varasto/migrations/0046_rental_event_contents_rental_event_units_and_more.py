# Generated by Django 4.0.3 on 2022-11-19 19:39

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('varasto', '0045_units'),
    ]

    operations = [
        migrations.AddField(
            model_name='rental_event',
            name='contents',
            field=models.DecimalField(blank=True, decimal_places=4, max_digits=11, null=True),
        ),
        migrations.AddField(
            model_name='rental_event',
            name='units',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='units', to='varasto.units'),
        ),
        migrations.AlterField(
            model_name='rental_event',
            name='amount',
            field=models.IntegerField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='units',
            name='unit',
            field=models.CharField(blank=True, choices=[('unit', 'kpl'), ('litre', 'l'), ('kilogram', 'kg'), ('meter', 'm'), ('volume', 'm³')], max_length=25, null=True),
        ),
    ]