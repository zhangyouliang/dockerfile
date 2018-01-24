from flask import Flask,render_template
import requests,json,os,sys

app = Flask(__name__)

@app.route('/')
def index():
    repositories = []
    namespace = {}
    res = requests.get("http://%s/v2/_catalog" % (RegistryURL))
    for repo in json.loads(res.text)['repositories']:
        r = repo.split('/')
        t_repositories = {}
        t_repositories['name'] = r[1]
        t_repositories['namespace'] = r[0]
        t_repositories['addr'] = RegistryURL + "/" + repo
        repositories.append(t_repositories)
        if not namespace.has_key(str(r[0])):
            namespace[r[0]] = 0
        namespace[r[0]] = int(namespace[r[0]]) + 1
    return render_template(
        'index.html',
        allimagenumber=len(json.loads(res.text)['repositories']),
        repositories=repositories,
        namespace=namespace,
    )

@app.route('/u/<namespace>')
def namespace(namespace):
    print(namespace)
    return "fff"

@app.route('/i/<namespace>/<name>')
def imageinfo(namespace,name):
    res = requests.get("http://%s/v2/%s/tags/list" % (RegistryURL,namespace+"/"+name))
    # json.loads()
    return res.text

if __name__ == '__main__':
    RegistryURL = os.environ.get("RegistryURL")
    if RegistryURL is None:
        print("Please set RegistryURL !")
        sys.exit()
    app.run(host="0.0.0.0", port=5000)