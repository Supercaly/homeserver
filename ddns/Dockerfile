FROM python:3-alpine

WORKDIR /src

# install dependencies
RUN apk add --no-cache \
    bash

# install python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# copy python scripts
COPY update.py ./

# copy bash scripts
COPY entrypoint.sh ./
RUN chmod +x ./*.sh

ENTRYPOINT ["/src/entrypoint.sh"]
