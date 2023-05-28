from os import environ
import sys
import datetime
from requests import get
import ipaddress
import socket

def timestr():
    return datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S")

print(f"[{timestr()}]: checking IP address...")

# get env variables and fail if they are not set.
if 'DDNS_URL' not in environ:
    sys.exit(f"[{timestr()}]: environment variable DDNS_URL is not set.")
ddns_domain = environ.get('DDNS_URL')
if 'DDNS_USER' not in environ:
    sys.exit(f"[{timestr()}]: environment variable DDNS_USER is not set.")
ddns_user = environ.get('DDNS_USER')
if 'DDNS_PWD' not in environ:
    sys.exit(f"[{timestr()}]: environment variable DDNS_PWD is not set.")
ddns_pwd = environ.get('DDNS_PWD')

# get current IP addrress and validate it.
res = get('https://api.ipify.org')
if res.status_code != 200:
    sys.exit(f"[{timestr()}]: cannot get local IP address (status {res.status_code}).")
current_ip = res.text
try:
    ipaddress.ip_address(current_ip)
except:
    sys.exit(f"[{timestr()}]: '{current_ip}' is not a valid IP address.")

# get domain ip address.
try:
    domain_ip = socket.gethostbyname(ddns_domain)
    ipaddress.ip_address(domain_ip)
except:
    sys.exit(f"[{timestr()}]: cannot get IP for domain '{ddns_domain}' or it is not a valid address.")

# update IP address calling the ddns service.
if current_ip != domain_ip:
    params={
        'username': ddns_user,
        'password': ddns_pwd,
        'hostname': ddns_domain,
        'myip': current_ip
    }
    res = get('https://api.dynu.com/nic/update', params=params)
    if (res.status_code != 200):
        sys.exit(f"[{timestr()}]: error updating IP address at '{res.url}' (status {res.status_code}.")
    else:
        print(f"[{timestr()}]: IP address updated, new IP: '{current_ip}'.")

