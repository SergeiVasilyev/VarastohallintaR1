from email.message import EmailMessage
import smtplib
from datetime import datetime
from django.db import models


# https://betterdatascience.com/send-emails-with-python/

def email_alert(subject, body, to):
    msg = EmailMessage()
    msg.set_content(body, subtype='html')
    msg['subject'] = subject
    msg['to'] = to

    VARASTO_EMAIL_USER = "info.varasto@gmail.com"
    msg['from'] = VARASTO_EMAIL_USER
    VARASTO_EMAIL_PASSWORD ="mbmxdxuhmjkojukb" 

    server = smtplib.SMTP("smtp.gmail.com", 587)
    server.starttls()
    server.login(VARASTO_EMAIL_USER, VARASTO_EMAIL_PASSWORD)
    server.send_message(msg)

    server.quit()

    "Tähän lisätään funktio mikä triggeröi muistutuksen"
# if datetime.today().date() == datetime.today().date():
#     email_alert("Automaattinen muistutus!", "Sinulla on lainassa (tähän työkalun nimi) joka on erääntynyt", "tino.cederholm@gmail.com")
