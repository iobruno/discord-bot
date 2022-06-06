FROM python:3.7-alpine

ADD requirements.txt /discord/
ADD main.py /discord/

WORKDIR /discord

RUN pip install -r requirements.txt
ENTRYPOINT ["python", "main.py"]
