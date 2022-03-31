# Generated by Django 4.0.3 on 2022-03-31 14:54

import django.contrib.auth.models
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
    ]

    operations = [
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('category', models.CharField(max_length=20)),
            ],
        ),
        migrations.CreateModel(
            name='Employee',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('first_name', models.CharField(max_length=30)),
                ('last_name', models.CharField(max_length=30)),
                ('username', models.CharField(max_length=20)),
                ('userpass', models.CharField(max_length=20)),
                ('phone', models.CharField(max_length=20)),
                ('email', models.CharField(max_length=30)),
            ],
        ),
        migrations.CreateModel(
            name='Goods',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('item_name', models.CharField(max_length=20)),
                ('brand', models.CharField(max_length=20)),
                ('model', models.CharField(max_length=20)),
                ('item_type', models.CharField(max_length=20)),
                ('size', models.CharField(max_length=20)),
                ('parameters', models.CharField(max_length=20)),
                ('package', models.CharField(max_length=20)),
                ('picture', models.CharField(max_length=20)),
                ('item_description', models.CharField(max_length=20)),
                ('cost_centre', models.CharField(max_length=20)),
                ('reg_number', models.CharField(max_length=20)),
                ('purchase_data', models.DateField()),
                ('purchase_price', models.DecimalField(decimal_places=2, max_digits=6)),
                ('purchase_place', models.CharField(max_length=20)),
                ('invoice_number', models.CharField(max_length=20)),
                ('categoryID', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='varasto.category')),
            ],
        ),
        migrations.CreateModel(
            name='Storage_name',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('storage_name', models.CharField(max_length=30)),
            ],
        ),
        migrations.CreateModel(
            name='Storage_place',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('rack', models.CharField(max_length=20)),
                ('shelf', models.CharField(max_length=20)),
                ('place', models.CharField(max_length=20)),
                ('amount', models.CharField(max_length=30)),
                ('itemID', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='varasto.goods')),
                ('storage_nameID', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='varasto.storage_name')),
            ],
        ),
        migrations.CreateModel(
            name='Staff_event',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('remarks', models.CharField(max_length=100)),
                ('from_storage', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='from_storage', to='varasto.storage_place')),
                ('itemID', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='varasto.goods')),
                ('to_storage', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='to_storage', to='varasto.storage_place')),
            ],
        ),
        migrations.CreateModel(
            name='Rental_event',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('remarks', models.CharField(max_length=255)),
                ('itemID', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='varasto.goods')),
                ('storageID', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='varasto.storage_place')),
            ],
        ),
        migrations.CreateModel(
            name='Student',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('last_login', models.DateTimeField(blank=True, null=True, verbose_name='last login')),
                ('is_superuser', models.BooleanField(default=False, help_text='Designates that this user has all permissions without explicitly assigning them.', verbose_name='superuser status')),
                ('first_name', models.CharField(max_length=30)),
                ('last_name', models.CharField(max_length=30)),
                ('username', models.CharField(max_length=20)),
                ('password', models.CharField(max_length=20)),
                ('phone', models.CharField(max_length=20)),
                ('email', models.CharField(max_length=30, unique=True)),
                ('student_code', models.CharField(max_length=20)),
                ('photo', models.CharField(max_length=20)),
                ('groups', models.ManyToManyField(blank=True, help_text='The groups this user belongs to. A user will get all permissions granted to each of their groups.', related_name='user_set', related_query_name='user', to='auth.group', verbose_name='groups')),
                ('user_permissions', models.ManyToManyField(blank=True, help_text='Specific permissions for this user.', related_name='user_set', related_query_name='user', to='auth.permission', verbose_name='user permissions')),
            ],
            options={
                'abstract': False,
            },
            managers=[
                ('objects', django.contrib.auth.models.UserManager()),
            ],
        ),
    ]
