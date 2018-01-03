FROM python:2.7.14

# RUN pip install aliyun-python-sdk-core aliyun-python-sdk-alidns flask docker paramiko qrcode pillow flask_login

ADD . /app

WORKDIR /app

RUN pip install -r requirements.txt

ENV ALIYUN_ID NULL
ENV ALIYUN_Secret NULL
ENV ALIYUN_RegionId cn-hangzhou

ENV Domain NULL
ENV ManagerIP NULL

ENV SPLUNK_URL http://http.splunk.com:8088
ENV SPLUNK_TOKEN xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

EXPOSE 8000

CMD ["python","ssserver.py"]
