FROM ubuntu:20.04
MAINTAINER Maxim Pershin

# Install required packages

RUN apt update -y
RUN apt install -y build-essential \
                   libfontconfig1 \
                   wget

# Download TexLive distribution

WORKDIR /dist
RUN wget https://mirror.macomnet.net/pub/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz \
         -O install.tar.gz
RUN mkdir install/
RUN tar -xvf install.tar.gz -C install \
        --strip-components=1

# Install TexLive distribution

WORKDIR /dist/install
RUN echo "selected_scheme scheme-full" > profile
RUN ./install-tl -profile ./profile

# Setup environment

WORKDIR /project
ENV HOME /project
ENV PATH="/usr/local/texlive/2021/bin/x86_64-linux:${PATH}"

