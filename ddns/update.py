import datetime
import os
import requests
import sys

IFCONFIGME_URL = "https://ifconfig.me/ip"
DYNU_URL = "https://api.dynu.com/nic/update"
TMP_ADDR_PATH = "/tmp/ddnsaddr"

#######
# Logs
#######
def logi(msg):
    time = datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
    print(f"{time} I: {msg}")

def loge(msg):
    time = datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
    print(f"{time} E: {msg}")

########
# Utils 
########
def get_last_ip():
    if (not os.path.isfile(TMP_ADDR_PATH)):
        loge("old ip address file not found")
        return None
    with open(TMP_ADDR_PATH, "r") as f:
        return f.readline().strip('\n')

def set_last_ip(new_ip):
    with open(TMP_ADDR_PATH, "w") as f:
        f.write(str(new_ip))
        f.write('\n')

def get_remote_ip():
    try:
        res = requests.get(IFCONFIGME_URL)
        return res.text if res.status_code == 200 else None
    except Exception as ex:
        loge(f"get_remote_ip: {ex}")
        return None

def update_ip(new_ip, hostname, pwd):
    try:
        params = {
            'hostname': hostname,
            'password': pwd,
            'myip': new_ip
        }
        res = requests.get(DYNU_URL, params=params)
        if (res.status_code != 200):
            loge(f"update_ip: call returned code {res.status_code}")
            return False
        message = res.text
        if (message.startswith("good") or message.startswith("nochg")):
            return True
        else:
            loge(f"update_ip: returned message {message}")
            return False
    except Exception as ex:
        loge(f"update_ip: {ex}")
        return False

################
# Main Function
################
if __name__ == "__main__":
    ddns_host = os.environ.get("DDNS_DOMAIN", None)
    if (ddns_host == None):
        loge("environment variable DDNS_DOMAIN not set")
        sys.exit(1)
    ddns_pwd = os.environ.get("DDNS_PWD", None)
    if (ddns_pwd == None):
        loge("environment variable DDNS_PWD not set")
        sys.exit(1)

    
    old_ip = get_last_ip()
    new_ip = get_remote_ip()

    if (new_ip == None):
        loge("error getting remote ip")
        sys.exit(1)
    
    if (old_ip != None):
        if (old_ip == new_ip):
            # IP is already updated... nothing else to do
            sys.exit(0)

    # Update the IP
    logi("updating IP address...")
    if (update_ip(new_ip, ddns_host, ddns_pwd)):
        set_last_ip(new_ip)
        logi("IP address updated!")
    else:
        loge("IP address not updated!")
