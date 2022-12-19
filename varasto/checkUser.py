

def user_check(user):
    if user.is_authenticated:
        return True
    else:
        return False

def is_not_student(user):
    if user.is_authenticated and (user.role == 'student'):
        return False
    else:
        return True

def is_menegement(user):
    if user.is_authenticated and (user.role == 'management'):
        return True
    else:
        return False

def is_storage_employee(user):
    if user.is_authenticated and (user.role == 'storage_employee'):
        return True
    else:
        return False

def is_student_ext(user):
    if user.is_authenticated and (user.role == 'student_ext'):
        return True
    else:
        return False

def is_super_user(user):
    if user.is_authenticated and user.is_superuser:
        return True
    else:
        return False