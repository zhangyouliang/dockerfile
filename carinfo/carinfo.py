#!/usr/bin/python3
# -*- coding: UTF-8 -*-
import json,sys,os,requests
from flask import Flask,render_template

app = Flask(__name__)
global Token
global Info

def Get_Token(username,password):
    url = "%s/%s" % (os.environ.get("URL") ,"/user-centre/oauth/token")
    headers = {
        'Authorization': 'Basic Y2xpZW50YXBwOjEyMzQ1Ng==',
        'Content-Type': 'application/x-www-form-urlencoded'
    }
    payload = {
        'grant_type': 'password',
        'username': username,
        'password': password,
        'scope': 'read',
        'client_secret': '123456',
        'client_id': 'clientapp'
    }
    response = requests.post(url, data=payload, headers=headers)
    data = json.loads(response.text)
    try:
        print (data)
        return data['access_token']
    except:

        return None

def Get_Info(Token):
    info = {}
    url = "%s/%s" % (os.environ.get("URL"), "/real-time/vehicle/statistics")
    headers = {
        'authorization': 'Bearer %s' % (Token),
        'cache-control': 'no-cache',
        'content-type': 'application/json'
    }
    response = requests.request("GET", url, headers=headers)
    data = json.loads(response.text)
    if 'status' in response.text:
        Token = Get_Token(USERNAME,PASSWORD)
        data = Get_Info(Token)
        return data
    else:
        info['onlineCount'] = data['data']['onlineCount']
        info['warnCount'] = data['data']['warnCount']
        info['inChargeCount'] = data['data']['inChargeCount']
        info['offlineCount'] = data['data']['offlineCount']
    return info

@app.route('/')
@app.route('/info.html')
def index():
    Info = Get_Info(Token)
    return render_template(
        "info.html",
        onlineCount=Info['onlineCount'],
        warnCount=Info['warnCount'],
        inChargeCount=Info['inChargeCount'],
        offlineCount=Info['offlineCount']
    )

if __name__ == '__main__':
    USERNAME = os.environ.get("USERNAME")
    PASSWORD = os.environ.get("PASSWORD")
    Token = Get_Token(USERNAME,PASSWORD)
    if Token is None:
        print ("Not get token,please check the nev-api-gateway app")
        sys.exit()
    app.run(host="0.0.0.0",port=8000)
