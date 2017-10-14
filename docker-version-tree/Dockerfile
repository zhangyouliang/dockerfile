FROM python:3.6.3
MAINTAINER "Cloth Mo" <root@buxiaomo.com>

RUN pip install pymysql docker Flask

ENV DB_HOST 127.0.0.1
ENV DB_USER root
ENV DB_PASS root
ENV DB_NAME test

add . /app

WORKDIR /app

EXPOSE 80

CMD ["python3","/app/server.py"]
