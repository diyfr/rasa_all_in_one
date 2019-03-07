FROM python:3.6-slim

SHELL ["/bin/bash", "-c"]

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends \
  build-essential \
  wget \
  openssh-client \
  graphviz-dev \
  pkg-config \
  git-core \
  openssl \
  libssl-dev \
  libffi6 \
  libffi-dev \
  libpng-dev \
  haskell-stack \
  libpcre3 \
  libpcre3-dev \
  libghc-zlib-dev \
  libghc-zlib-bindings-dev \
  curl && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

#RASA_CORE
RUN pip install rasa_core

#RASA_NLU
RUN pip install rasa_nlu[spacy]

#RASA_SDK
RUN pip install rasa_core_sdk

#DUCKLING
RUN mkdir /duck
WORKDIR /duck
RUN git clone https://github.com/facebook/duckling.git
WORKDIR /duck/duckling
RUN stack setup
RUN stack build


EXPOSE 5005
