from email.message import EmailMessage
import smtplib
from datetime import datetime
from .models import User, Rental_event

def email_alert(subject, body, to):
    msg = EmailMessage()
    msg.set_content(body)
    msg['subject'] = subject
    msg['to'] = to

    user = "muistutus.varasto@gmail.com (tämä sähköposti on vain esimerkki)"
    password ="salasana (jos käyttää gmail niin pitää setup 2-step verification ensin että saa salasanan sitä varten että third party sovellus pystyy lähettämään sähköpostin kautta)" 

    server = smtplib.SMTB("smtp.gmail.com", 587)
    server.starttls()
    server.login(user, password)

    server.quit()

    "Tähän lisätään funktio mikä triggeröi muistutuksen"
    if ("estimated_date") == datetime.today().date():
        email_alert("Automaattinen muistutus!", "Sinulla on lainassa (tähän työkalun nimi) joka on erääntynyt", "(tähän laitetaan käyttäjän sähköposti")
