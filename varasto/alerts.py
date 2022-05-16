from email.message import EmailMessage
import smtplib
from datetime import datetime
from django.db import models




def email_alert(subject, body, to):
    msg = EmailMessage()
    msg.set_content(body)
    msg['subject'] = subject
    msg['to'] = to

    user = "info.varasto@gmail.com"
    msg['from'] = user
    password ="mbmxdxuhmjkojukb" 

    server = smtplib.SMTP("smtp.gmail.com", 587)
    server.starttls()
    server.login(user, password)
    server.send_message(msg)

    server.quit()

    "Tähän lisätään funktio mikä triggeröi muistutuksen"
if datetime.today().date() == datetime.today().date():
    email_alert("Automaattinen muistutus!", "Sinulla on lainassa (tähän työkalun nimi) joka on erääntynyt", "tino.cederholm@gmail.com")
