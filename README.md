# Warehouse Management System
Warehouse Management and Equipment Rental System built with Django and PostgreSQL.

## Overview
VarastohallintaR1 is a web-based warehouse management system designed for educational institutions and organizations that need to manage inventory, equipment rentals, and user access control.

The system allows administrators, warehouse employees, teachers, and students to manage and rent equipment through a centralized platform with role-based permissions, notifications, and reporting features.

## Technology Stack
### Backend
- Python
- Django
- PostgreSQL
  
### Frontend
- HTML
- CSS
- JavaScript
- JQuery

## Demo
http://5.61.88.179:8880

Student_ext: user3, Q2wertyy

Management: user4, Q2wertyy

Storage employee: user5, Q2wertyy

Storage employee2: user25, Q2wertyy

Storage employee3: user26, Q2wertyy

Storage employee3: user27, Q2wertyy


## Features
### User Roles and Permissions

The system supports multiple user roles:

- Administrator
- Warehouse Employee
- Management
- Teacher
- Student
- Advanced Student

Each role has different permissions and access levels.

### Warehouse Management
- Create and manage warehouses
- Add, edit, and remove products
- Track inventory quantities
- Move items between warehouses
- Manage equipment categories

### Equipment Rental System
- Rent equipment and products
- Return rented items
- Track active rentals
- Due date management
- Reservation workflow

### Notifications and Email System
- Email notifications
- Return reminders
- User notifications
- Rental status updates

### Reporting
Generate reports for:

- Active rentals
- Inventory status
- Warehouse activity
- Overdue returns
- User activity

## Database Design
The system is built around several core entities:

- Users
- Roles
- Warehouses
- Products
- Inventory
- Rentals
- Notifications
- Audit Logs

The project uses PostgreSQL for reliable relational data management.

## Possible Future Improvements
- Docker support (in progress)
- REST API with Django REST Framework
- React or Vue frontend
- Celery background tasks
- Automated testing
- CI/CD pipeline
- Mobile application support

## Educational Purpose
This project demonstrates:

- Backend architecture with Django
- Role-based access control
- Relational database design
- Inventory management workflows
- Rental management systems
- Email notification systems
- Audit logging and reporting


