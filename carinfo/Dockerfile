FROM python:3.6.1

RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple flask requests

ADD . /app

ENV URL NULL
ENV USERNAME NULL
ENV PASSWORD NULL

WORKDIR /app
EXPOSE 8000

CMD ["python","carinfo.py"]
