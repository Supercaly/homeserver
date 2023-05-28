FROM python:3-alpine

WORKDIR /usr/src/ddns

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY check.py ./

COPY crontab /etc/crontabs/root

CMD ["crond", "-f", "-l", "2"]

