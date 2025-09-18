#!/usr/bin/python3

import requests
import time
import logging
import xml.etree.ElementTree as ET


class FailedLogin(Exception):
    pass


logging.basicConfig(
    filename='/var/log/nm-dispatcher-captivepass.log',
    filemode='a',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

GOOGLE_GEN_204_URL = "http://clients1.google.com/generate_204"
URL = 'https://10.100.1.1:8090/login.xml'

# Change username and password as necessary

CREDENTIALS = [('ersg', 'ersg'), ('surya', 'surya')]


def iscaptive(retry_count=3):
    return True
    try:
        r = requests.get(GOOGLE_GEN_204_URL)
    except (
        requests.exceptions.Timeout,
        requests.exceptions.ConnectTimeout,
        requests.exceptions.ConnectionError,
    ) as e:
        if retry_count:
            logging.info(f"Got {repr(e)}, retying")
            return iscaptive(retry_count - 1)
        return False
    except Exception as e:
        logging.error(f"Exception: {repr(e)}")
        return False
    if r.status_code != 204:
        return True
    else:
        logging.info(f"Captive Check: Not inside portal, got {r.status_code}")
        return False


def login(username, password):
    headers = {
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br, zstd',
        'Accept-Language': 'en-US,en',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
        'Content-Type': 'application/x-www-form-urlencoded'
    }

    DATA = {
        'mode': 191,
        'username': username,
        'password': password,
        'a': int(time.time()),
        'producttype': 0
    }
    r = requests.post(URL, data=DATA, headers=headers, verify=False)
    status_xml = ET.fromstring(r.text)
    status = status_xml.find('status').text
    status_message = status_xml.find('message').text
    logging.info(f"CaptivePortal Login: {status_message}")

    if status == 'LOGIN':
        raise FailedLogin


if __name__ == "__main__":
    logging.info("CaptiveCheck started")
    if iscaptive():
        for cred in CREDENTIALS:
            try:
                login(*cred)
            except FailedLogin:
                continue
            except Exception as e:
                logging.error(f"Couldn't pass the captive portal, {e}")
            break
