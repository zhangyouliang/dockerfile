FROM python:2.7.14

RUN pip install aliyun-python-sdk-core aliyun-python-sdk-alidns flask docker paramiko

ADD . /app

ENV ALIYUN_ID NULL
ENV ALIYUN_Secret NULL
ENV ALIYUN_RegionId cn-hangzhou

ENV Domain NULL

EXPOSE 8000

CMD ["python","/app/ssserver.py"]