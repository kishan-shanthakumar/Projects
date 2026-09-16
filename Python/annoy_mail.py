import requests
import bs4
import smtplib
import time
from os import system,name

def clear():
    if name == 'nt':
        _=system('cls')
    else:
        _=system('clear')

server=smtplib.SMTP('smtp.gmail.com',587)
server.ehlo()
server.starttls()
server.ehlo()
print("Enter the email-id")
usr=input()
print("Enter the password")
pas=input()
clear()
server.login(usr,pas)
print("Login succesful\n\n\n\nPress ENTER to continue")
input()
print("Enter Subject of the mail : ",end='')
subject=input()
print("Enter the body of the mail : ",end='')
body=input()
print("Enter the recipient email address")
rece=input()
msg = f"Subject:{subject}\n\n{body}"
while(True):
    server.sendmail(
        usr,
        rece,
        msg
    )
    print('HEY E-MAIL HAS BEEN SENT')
    time.sleep(10)
server.quit()
