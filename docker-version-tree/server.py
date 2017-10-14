#!/usr/lib/python3
# -*- coding: UTF-8 -*-
import os
from flask import Flask,render_template,request
import pymysql
import docker

app = Flask(__name__)

def Connent_DB(host,name,passwd,dbname):
    return pymysql.connect(host, name, passwd, dbname)

def Init_Table(conn):
    # 使用 cursor() 方法创建一个游标对象 cursor
    cursor = conn.cursor()
    # 使用 execute() 方法执行 SQL，如果表存在则删除
    try:
        # 执行SQL语句
        tablename = []
        cursor.execute("SHOW TABLES;")
        # 获取所有记录列表
        results = cursor.fetchall()
        for row in results:
            tablename.append(row[0])
        if "service" not in tablename:
            print ("Create service table")
            sql = """CREATE TABLE `service` (
            `id`  int NOT NULL AUTO_INCREMENT ,
            `name`  varchar(255) NOT NULL ,
            PRIMARY KEY (`id`));"""
            cursor.execute(sql)
        if "version" not in tablename:
            print ("Create version table")
            sql = """CREATE TABLE `version` (
              `id` int(11) NOT NULL AUTO_INCREMENT,
              `upversiontime` datetime NOT NULL,
              `serviceid` int(11) NOT NULL,
              `version` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
              `note` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
              PRIMARY KEY (`id`),
              KEY `serviceid` (`serviceid`),
              CONSTRAINT `serviceid` FOREIGN KEY (`serviceid`) REFERENCES `service` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
            ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;"""
            cursor.execute(sql)
            print ("Table created successfully")
    except:
        print ("Error: unable to fetch data")

def Get_Services():
    BlackList = [
        'dce-plugin_netlb',
        'dce-plugin_dcleaner',
        'dce-plugin_applb',
        'dce-plugin_ntp',
        'dce_base',
        'dcx_px-lighthouse',
        'dcx_influxdb'
    ]
    client = docker.DockerClient(base_url='unix://var/run/docker.sock')
    for services in client.services.list():
        if services.name not in BlackList:
            SQL = "INSERT INTO `evm`.`service` (`name`) VALUES ('%s');" % (services.name)
            cursor = db.cursor()
            try:
               cursor.execute(SQL)
               db.commit()
            except:
               db.rollback()
                # now();
            Version = services.attrs['Spec']['TaskTemplate']['ContainerSpec']['Image']
            Version = Version.split("/")[-1].split(":")[1].replace("@sha256","")

            SQL = "select id from service WHERE name='%s';" % (services.name)
            cursor.execute(SQL)
            results = cursor.fetchall()
            for row in results:
                Server_ID = row[0]
            print (Server_ID)
            SQL = "INSERT INTO `evm`.`version` (`upversiontime`, `serviceid`, `version`, `note`) VALUES (now(), '%s', '%s', '');" % (Server_ID,Version)
            cursor = db.cursor()
            try:
               cursor.execute(SQL)
               db.commit()
            except:
               db.rollback()

@app.route('/')
@app.route('/index.html')
def index():
    ID = request.args.get('id')
    if ID == None:
        cursor = db.cursor()
        SQL = "SELECT id,name FROM service;"
        # 执行SQL语句
        cursor.execute(SQL)
        # 获取所有记录列表
        results = cursor.fetchall()
        services = []
        for row in results:
            tmp = {}
            tmp['id'] = row[0]
            tmp['name'] = row[1]
            services.append(tmp)
            # 打印结果
        return render_template(
            "index.html",
            data=services
        )
    else:
        services = []
        version = []
        cursor = db.cursor()
        SQL = "SELECT id,name FROM service;"
        cursor.execute(SQL)
        results = cursor.fetchall()
        for row in results:
            tmp = {}
            tmp['id'] = row[0]
            tmp['name'] = row[1]
            services.append(tmp)

        SQL = """SELECT service.name,version.upversiontime AS time,version.version
FROM service INNER JOIN version
ON service.id = version.serviceid WHERE service.id=%s ORDER BY time DESC ;""" % (ID)
        cursor.execute(SQL)
        results = cursor.fetchall()
        name =''
        for row in results:
            tmp = {}
            name = row[0]
            tmp['upversiontime'] = str(row[1])
            tmp['version'] = row[2]
            version.append(tmp)
        return render_template(
            "index.html",
            data=services,
            version=version,
            name=name
        )

if __name__ == '__main__':
    DB_HOST = os.environ.get("DB_HOST")
    DB_USER = os.environ.get("DB_USER")
    DB_PASS = os.environ.get("DB_PASS")
    DB_NAME = os.environ.get("DB_NAME")
    db = Connent_DB(DB_HOST, DB_USER, DB_PASS, DB_NAME)
    Init_Table(db)
    app.run(debug=True,host="0.0.0.0",port=80)

# if __name__ == '__main__':
#     db = Connent_DB("10.99.6.38", "root", "root", "evm")
#     print ("Opened database successfully")
#     Init_Table(db)
#     Get_Services()
#     db.close()
