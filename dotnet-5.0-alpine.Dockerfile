# ----------------------------------
# Pterodactyl .NET Core 5.0 Pterodactyl Image DockerFile
# Environment: Linux
# ----------------------------------
FROM mcr.microsoft.com/dotnet/runtime:5.0-alpine AS base
MAINTAINER Indungi Services SRL, <senarisk@gmail.com>

RUN apk update && apk add bash
RUN apk add --no-cache --update curl ca-certificates openssl git tar zip bash fontconfig wget \
    && adduser --disabled-password --home /home/container container
RUN apk add dos2unix

COPY ./dotnet-5.0-alpine.sh entrypoint.sh
COPY ./dotnet-5.0-alpine.sh /home/container/entrypoint.sh

RUN dos2unix entrypoint.sh
RUN dos2unix /home/container/entrypoint.sh
RUN chmod +x /home/container/entrypoint.sh
RUN chmod +x entrypoint.sh
WORKDIR /home/container

USER container
ENV  USER=container HOME=/home/container

ENTRYPOINT ["/entrypoint.sh"]
