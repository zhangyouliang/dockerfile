# -*- coding: UTF-8 -*-
from flask import Flask,render_template,request
from flask_sqlalchemy import SQLAlchemy
import os,json

app = Flask(__name__)
basedir = os.path.abspath(os.path.dirname(__file__))
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'db/data.sqlite')
app.config['SQLALCHEMY_COMMIT_ON_TEARDOWN'] = True
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
db = SQLAlchemy(app)

class Love(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer,primary_key=True)
    title = db.Column(db.String(255),unique=True)
    lovename = db.Column(db.String(255),unique=True)
    yourname = db.Column(db.String(255),unique=True)
    text = db.Column(db.String(255), unique=False, nullable=True)
    mp4 = db.Column(db.String(255),unique=False,nullable=True)
    backgroundimg = db.Column(db.String(255),unique=False,nullable=True)
    description = db.Column(db.String(255),unique=False,nullable=True)
    keywords = db.Column(db.String(255),unique=False,nullable=True)
    def __repr__(self):
        return '<Vin %r>' % self.name

@app.route('/check',methods=['POST'])
def check():
    if request.method == 'POST':
        Name = Love.query.filter_by(lovename=request.values.get('domain')).first()
        if Name is None:
            r = False
        else:
            r = True
    return json.dumps({"r": r})
@app.route('/')
def index():
    if request.host.find("xn--rhqy1la1825a.xn--6qq986b3xl") == -1:
        return '<h1>Access denied</h1>', 403
    Name = request.host.split(".")[0].replace("xn--","").decode('punycode')
    Name = Love.query.filter_by(lovename=Name).first()
    if Name is None:
        return '<h1>Access denied</h1>', 403
    if Name.lovename == u"主页":
        return render_template(
            'main.html',
            title=Name.title,
            description=Name.description,
            keywords=Name.keywords,
            mp4=Name.mp4,
            backgroundimg=Name.backgroundimg
        )
    return render_template(
        'index.html',
        title=Name.title,
        yourname=Name.yourname,
        mp4=Name.mp4,
        backgroundimg=Name.backgroundimg,
        text=Name.text,
        description=Name.description,
        keywords=Name.keywords
    )
if __name__ == '__main__':
    app.run(host="0.0.0.0",port=8000)