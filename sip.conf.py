#!/usr/bin/python3

import sys

SIP_CONF_GENERAL_TEMPLATE = """
[general]
bindport = 5060
bindaddr = 0.0.0.0
tcpenable=yes
tcpbindaddr=0.0.0.0
;bindaddr = 192.168.0.254
;videosupport = yes
callcounter=yes
srvlookup = no
callevents=yes

localnet=10.169.10.0/255.255.255.0

allowsubscribe = yes
notifyringing = yes
xfersound = on
rtcachefriends = yes
limitonpeer = yes
notifyhold = yes
t38pt_udptl=yes
accept_outofcall_message = yes
outofcall_message_context = messages
auth_message_requests = no

session-timers=accept
session-expires=120

context = local1
disallow = all
;allow = gsm
allow = ulaw
allow = alaw
;allow=g729
"""

SIP_CONF_NUMBER_TEMPLATE = """
[PHONE_NUMBER]
type = friend
secret = voiPpassPHONE_NUMBER
username = PHONE_NUMBER
callerid = "PHONE_NUMBER" <PHONE_NUMBER>
host = dynamic
context = office896
pickupgroup = 1
callgroup = 1
qualify = 1000
amaflags = billing
"""

SIP_FILE = "sip.conf"

params = sys.argv[1:]

# Get input number
selected_number = 0

if params:
    selected_number = int(params[0])
    print(f'Given number is: {selected_number}')
else:
    while True:
        try:
            selected_number = int(input("Enter an integer 1-99: "))
        except ValueError:
            print("Please enter a valid number 1-99")
            continue
        if selected_number in range(1, 100):
            print(f'You entered: {selected_number}')
            break
        else:
            print('The integer must be in the range 1-99')

# Generate sip.conf contents
sip_content = SIP_CONF_GENERAL_TEMPLATE
for number in range(1,selected_number+1):
    phone_number = "10" + str(number)
    number_section = SIP_CONF_NUMBER_TEMPLATE.replace("PHONE_NUMBER", phone_number)
    sip_content += number_section

# Write sip.conf file
with open("sip.conf", "w") as text_file:
    text_file.write(sip_content)

print(f'Created: {SIP_FILE}')
