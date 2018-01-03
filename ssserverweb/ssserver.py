#!/usr/bin/env python2
# -*- coding: UTF-8 -*-
# @Time    : 2017/11/10 14:45
# @File    : ssserver.py
import docker,json,os,paramiko,threading,time,re,qrcode,base64,sys
from PIL import Image
from flask import Flask,render_template,request,Response,url_for,redirect
from flask_login import LoginManager,login_user,UserMixin,logout_user,login_required
from flask_sqlalchemy import SQLAlchemy
from aliyunsdkcore import client
from aliyunsdkalidns.request.v20150109 import DescribeDomainRecordsRequest

app = Flask(__name__)

global ALIYUN_ID
global ALIYUN_Secret
global ALIYUN_RegionId
global clt
global DomainName
global Task
global SPLUNK_URL
global SPLUNK_TOKEN

def AddHostTask(SSHIP,SSHPORT, SSHUSER, SSHPASS,OS,NAME):
    try:
        client = docker.DockerClient(base_url='unix://var/run/docker.sock')
        WorkerToken = client.swarm.attrs['JoinTokens']['Worker']
        ManagerIP = os.environ.get("ManagerIP")
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(SSHIP, int(SSHPORT), SSHUSER, SSHPASS)
        t = paramiko.Transport((SSHIP, int(SSHPORT)))
        t.connect(username=SSHUSER, password=SSHPASS)
        shell = ssh.invoke_shell()
        if OS == "Ubuntu":
            command = [
                'apt-get install apt-transport-https facter ca-certificates curl gnupg2 software-properties-common -y\n',
                'echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable" >> /etc/apt/sources.list\n',
                'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -\n',
                'apt-get update\n',
                'apt-get install docker-ce -y\n',
                'systemctl restart  docker.service\n',
                'docker swarm join --token %s %s:2377\n' % (WorkerToken,ManagerIP)
            ]
        if OS == "CentOS":
            command = [
                'yum install -y yum-utils device-mapper-persistent-data lvm2 curl\n',
                'yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo\n',
                'yum -y install docker-ce\n',
                'systemctl restart  docker.service\n',
                'docker swarm join --token %s %s:2377\n' % (WorkerToken,ManagerIP)
            ]
        for cmd in command:
            shell.send(cmd)
            while not shell.recv_ready():
                time.sleep(1)
            buff = shell.recv(1024)
            base_prompt = r'(>|#|\]|\$|\)) *$'
            while (not re.search(base_prompt, buff.split('\n')[-1])):
                _buff = shell.recv(1024)
                buff += _buff
                print buff
                if buff.find("This node joined a swarm as a worker") != -1:
                    Task[NAME] = "Success"
                else:
                    Task[NAME] = "Failure"
        ssh.close()
    except:
        Task[NAME] = "Failure"

def GetAllDomainRecords(DomainN):
    clt = client.AcsClient(ALIYUN_ID, ALIYUN_Secret, ALIYUN_RegionId)
    AddDomainRecord = DescribeDomainRecordsRequest.DescribeDomainRecordsRequest()
    AddDomainRecord.set_accept_format('json')
    AddDomainRecord.set_DomainName(DomainN)
    AddDomainDomainJson = json.loads(clt.do_action_with_exception(AddDomainRecord))
    Domain = {}
    for d in AddDomainDomainJson['DomainRecords']['Record']:
        Domain[d['Value']] = "%s.%s" %(d['RR'],DomainN)
    return(Domain)

@app.route('/addhost.html',methods=["Post"])
def addhost():
    if request.method == 'POST':
        SSHIP = request.form['sship']
        SSHPORT = request.form['sshport']
        SSHUSER = request.form['sshuser']
        SSHPASS = request.form['sshpass']
        OS = request.form['os']
        NAME = int(round(time.time() * 1000))
        t1 = threading.Thread(target=AddHostTask, args=(SSHIP, int(SSHPORT), SSHUSER, SSHPASS,OS,NAME))
        t1.start()
        return Response(json.dumps({"TaskID": NAME}), mimetype='application/json')

@app.route('/adduser.html',methods=["Post"])
def adduser():
    if request.method == 'POST':
        USERNAME = request.form['ssuser']
        PASSWORD = request.form['sspass']
        SSPORT = request.form['ssport']
        ADDPASS = request.form['addpass']
        if ADDPASS != "liu123...":
            return Response(json.dumps({"result": "error"}), mimetype='application/json')
        client = docker.DockerClient(base_url='unix://var/run/docker.sock')
        try:
            client.services.create(
                name="ss_%s" % (USERNAME),
                image="daocloud.io/buxiaomo/ssserver:2.8.2",
                env={
                    "PASSWORD": PASSWORD
                },
                mode=docker.types.ServiceMode(mode="global"),
                endpoint_spec=docker.types.EndpointSpec(
                    mode="vip",
                    ports={
                        int(SSPORT): (8388, 'tcp')
                    }
                ),
                labels={
                    "com.docker.stack.image": "daocloud.io/buxiaomo/ssserver:2.8.2",
                    "com.docker.stack.namespace": "ss"
                },
                constraints=[
                    "node.role == worker"
                ],
                container_labels={"com.docker.stack.namespace": "ss"},
                networks=["ss"],
                log_driver="splunk",
                log_driver_options={
                    "splunk-url": SPLUNK_URL,
                    "splunk-token": SPLUNK_TOKEN,
                    "tag": "{{.Name}}"
                },
                healthcheck=docker.types.Healthcheck(
                    test="nc -w 1 localhost 8388 -z",
                    interval=10000000000,
                    timeout=10000000000,
                    retries=5
                )
            )
            result = "success"
        except:
            result = "error"
        return Response(json.dumps({"result": result}), mimetype='application/json')


@app.route('/erweima.html',methods=["Post"])
def erweima():
    if request.method == 'POST':
        hostname = request.form['hostname']
        port = request.form['port']
        password = request.form['password']
        method = request.form['method']
        print(hostname,port,password,method)
        qr = qrcode.QRCode(
            version=1,
            error_correction=qrcode.constants.ERROR_CORRECT_L,
            box_size=10,
            border=4,
        )
        qr.add_data("ss://%s" % (base64.b64encode("%s:%s@%s:%s" % (method,password,hostname,port))))
        qr.make(fit=True)
        img = qr.make_image()
        img.save("static/erweima/pictname.png")
        return redirect(url_for('/static/erweima/pictname.png'))

@app.route('/taskresult/<int:taskid>')
def InquireTaskResult(taskid):
    if taskid in Task:
        return Response(json.dumps({"result": Task[taskid]}), mimetype='application/json')
    else:
        return Response(json.dumps({"result": "None"}), mimetype='application/json')


@app.route('/')
@app.route('/index')
def index():
    client = docker.DockerClient(base_url='unix://var/run/docker.sock')
    HOSTLIST = []
    USERLIST = []
    Domain = GetAllDomainRecords(DomainName)
    for nodes in client.nodes.list(filters={'role': 'worker'}):
        tmp = {}
        tmp['State'] = nodes.attrs['Status']['State']
        if nodes.attrs['Status']['Addr'] in Domain:
            tmp['Addr'] = Domain[nodes.attrs['Status']['Addr']]
        else:
            tmp['Addr'] = nodes.attrs['Status']['Addr']
        tmp['MemoryBytes'] = int(nodes.attrs['Description']['Resources']['MemoryBytes']) / 1024 / 1024
        HOSTLIST.append(tmp)
    for services in client.services.list():
        tmp = {}
        if services.name.find("ss_") != -1:
            tmp['name'] = services.name.replace("ss_","")
            if services.attrs['Endpoint']['Ports'][0]['TargetPort'] == 8388:
                tmp['PublishedPort'] = services.attrs['Endpoint']['Ports'][0]['PublishedPort']
            tmp['password'] = services.attrs['Spec']['TaskTemplate']['ContainerSpec']['Env'][0].replace("PASSWORD=", "")
            tmp['password'] = tmp['password'][:2] + "******" + tmp['password'][len(tmp['password']) - 2:]
            USERLIST.append(tmp)
    return render_template(
        "index.html",
        HOSTLIST=HOSTLIST,
        USERLIST=USERLIST
    )

if __name__ == '__main__':
    if os.path.exists('/var/run/docker.sock') == False:
        sys.exit()
    ALIYUN_ID = os.environ.get("ALIYUN_ID")
    ALIYUN_Secret = os.environ.get("ALIYUN_Secret")
    ALIYUN_RegionId = os.environ.get("ALIYUN_RegionId")
    DomainName = os.environ.get("DomainName")
    SPLUNK_URL = os.environ.get("SPLUNKHOST")
    SPLUNK_TOKEN = os.environ.get("SPLUNK_TOKEN")
    Task = {}
    app.run(debug=True, host="0.0.0.0", port=8000)
