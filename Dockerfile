FROM python:3.11

SHELL ["/bin/bash", "-eo", "pipefail", "-c"]

COPY moto.sh /

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install git \
    && useradd -u 1000 -m -d /home/python -s /bin/bash python \
    && chmod 555 /moto.sh

USER python

WORKDIR /home/python

RUN git clone https://github.com/cnaude/moto.git moto-git \
    && mv moto-git/* . \
    && python -m venv venv \
    && source venv/bin/activate \
    && python -m pip install --upgrade pip \
    && pip install -r requirements.txt

CMD [ "/moto.sh" ]

