FROM debian:bullseye-slim

ENV MYDUMPER_VERSION=0.12.5-3

RUN apt -qq update && apt -qq -y upgrade && \
    apt -qq -y --no-install-recommends install wget ca-certificates libatomic1 libglib2.0-0 mysql-common mariadb-common && \
    wget --quiet https://github.com/mydumper/mydumper/releases/download/v${MYDUMPER_VERSION}/mydumper_${MYDUMPER_VERSION}.bullseye_amd64.deb && \
    dpkg -i mydumper_${MYDUMPER_VERSION}.bullseye_amd64.deb && \
    rm mydumper_${MYDUMPER_VERSION}.bullseye_amd64.deb
