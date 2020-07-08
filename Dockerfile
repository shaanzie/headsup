FROM python:3.7-slim
ADD ./shared-volume /todo
WORKDIR /todo
RUN pip install --no-cache-dir flask flask-cors pymongo

