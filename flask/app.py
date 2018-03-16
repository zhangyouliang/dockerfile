#-*- coding=utf-8 -*-
from flask import Flask, render_template, url_for, request, redirect
import pymongo

app = Flask(__name__)

db_name='PornHub'
col_name='PhRes'

page_size=10

@app.route('/')
def index():

    client = pymongo.MongoClient('mongodb://PornHub:123456@118.31.78.77:27017/PornHub')
    db = client[db_name]
    collection_set01 = db[col_name]

    current_page = request.args.get('page', 1, type=int)
    if collection_set01.find().count() % page_size == 0:
        max_page =  collection_set01.find().count() / page_size
    else:
        max_page =  (collection_set01.find().count() / page_size)+1

    data = collection_set01.find({},).limit(page_size).skip(page_size *(current_page-1))

    pagination={}
    pagination['has_next'] = False if current_page>=max_page else True
    pagination['has_pre'] = False if current_page<=1 else True
    pagination['next_page'] =  current_page if current_page>=max_page else current_page+1
    pagination['pre_page'] = 1 if current_page<=1 else current_page-1

    return  render_template('index.html',entries=data,pagination=pagination)

@app.route("/hello")
def hello():
    return  'hello, world'

@app.route("/user/<username>")
def show_user_profile(username):
    return 'User %s' % username

# string(default) int float path any uuid
@app.route('/post/<int:post_id>')
def show_post(post_id):
    # show the post with the given id, the id is an integer
    return 'Post %d' % post_id

def do_the_login():
    return redirect(url_for('login'))
def show_the_login_form():
    return render_template('login.html',)

@app.route('/login',methods=['GET','POSt'])
def login():
    if request.method == 'POST':
        do_the_login()
    else:
        show_the_login_form()

@app.errorhandler(404)
def page_not_found(error):
    return  render_template('404.html'),404


if __name__ == "__main__":
    app.run(host='0.0.0.0',port=80)




