import docker,json,os,paramiko
from flask import Flask,render_template,request,Response
from aliyunsdkcore import client
from aliyunsdkalidns.request.v20150109 import DescribeDomainRecordsRequest

app = Flask(__name__)
global ALIYUN_ID
global ALIYUN_Secret
global ALIYUN_RegionId
global clt
global DomainName

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

        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(SSHIP, int(SSHPORT), SSHUSER, SSHPASS)
        t = paramiko.Transport((SSHIP, int(SSHPORT)))
        t.connect(username=SSHUSER, password=SSHPASS)
        stdin, stdout, stderr = ssh.exec_command('ps -aux | grep "/usr/bin/dockerd" &> /dev/null && echo running')
        if stdout.read().find("running") != -1:
            stdin, stdout, stderr = ssh.exec_command('docker swarm join --token SWMTKN-1-5gtz9muww359g0o3xjo36k8qrikef71p8823jl2m5oexeyfq2g-avyomjqsbd8vaqcz1griedbbg 45.77.157.7:2377')
            if stdout.read().find("This node joined a swarm as a worker") != -1:
                print("add success")
            else:
                print("add error")
        else:
            print("not run")
        ssh.close()
        return Response(json.dumps({"result": "1"}), mimetype='application/json')

@app.route('/')
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
        tmp['name'] = services.name.replace("ss_","")
        if services.attrs['Endpoint']['Ports'][0]['TargetPort'] == 8388:
            tmp['PublishedPort'] = services.attrs['Endpoint']['Ports'][0]['PublishedPort']
        tmp['password'] = services.attrs['Spec']['TaskTemplate']['ContainerSpec']['Env'][0].replace("PASSWORD=", "")
        USERLIST.append(tmp)
    return render_template(
        "index.html",
        HOSTLIST=HOSTLIST,
        USERLIST=USERLIST
    )

if __name__ == '__main__':
    ALIYUN_ID = os.environ.get("ALIYUN_ID")
    ALIYUN_Secret = os.environ.get("ALIYUN_Secret")
    ALIYUN_RegionId = os.environ.get("ALIYUN_RegionId")

    DomainName = os.environ.get("DomainName")
    app.run(debug=True, host="0.0.0.0", port=8000)
