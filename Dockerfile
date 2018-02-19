FROM ubuntu:latest
MAINTAINER om3rcitak "omer@netsparker.com"


# general

RUN apt-get update \
  && apt-get install -y software-properties-common \
  && apt-get install apt-transport-https


# install osquery

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B \
  && add-apt-repository "deb [arch=amd64] https://osquery-packages.s3.amazonaws.com/xenial xenial main"

RUN apt-get update \
  && apt-get install -y osquery


# install python3 and pip
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip


# settings

RUN rm -rf /var/lib/apt/lists/*
COPY osquery.example.conf /etc/osquery/osquery.conf
COPY server.py /server.py

EXPOSE 35275

CMD ["osqueryd", "--config_path=/etc/osquery/osquery.conf", "--verbose"]


# install pip requirements

RUN pip3 install flask
RUN pip3 install osquery

# start web server

CMD ["python3", "server.py"]
