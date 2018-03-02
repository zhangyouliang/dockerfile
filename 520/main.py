# -*- coding: UTF-8 -*-
from flask import Flask,render_template,request
from flask_sqlalchemy import SQLAlchemy
import os

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
    def __repr__(self):
        return '<Vin %r>' % self.name

@app.route('/')
def hello_world():
    Name = request.host.split(".")[0].replace("xn--","").decode('punycode')
    Name = Love.query.filter_by(lovename=Name).first()
    if Name is None:
        return '<h1>Access denied</h1>', 403
    return render_template(
        'index.html',
        title=Name.title,
        yourname=Name.yourname,
        mp4=Name.mp4,
        backgroundimg=Name.backgroundimg,
        text=Name.text
    )
if __name__ == '__main__':
    app.run(host="0.0.0.0",port=8000)