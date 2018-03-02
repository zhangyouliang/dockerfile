FROM python:2.7.14-alpine3.7

RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple flask flask-sqlalchemy requests

COPY . /app

VOLUME /app/db

EXPOSE 8000

WORKDIR /app

CMD ["python","main.py"]