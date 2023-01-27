from email.message import EmailMessage
import smtplib
from datetime import datetime
from django.db import models
from .storage_settings import *


# https://betterdatascience.com/send-emails-with-python/

def email_alert(subject, body, to):
    msg = EmailMessage()
    msg.set_content(body, subtype='html')
    msg['subject'] = subject

    msg['from'] = STORAGE_EMAIL
    msg['to'] = to

    server = smtplib.SMTP(EMAIL_SERVER, 587)
    server.starttls()
    server.login(STORAGE_EMAIL, EMAIL_PASS)
    server.send_message(msg)

    server.quit()

    "Tähän lisätään funktio mikä triggeröi muistutuksen"
# if datetime.today().date() == datetime.today().date():
#     email_alert("Automaattinen muistutus!", "Sinulla on lainassa (tähän työkalun nimi) joka on erääntynyt", "tino.cederholm@gmail.com")
