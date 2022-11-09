FROM        --platform=$TARGETOS/$TARGETARCH ghcr.io/parkervcp/yolks:debian

LABEL       author="Tita Junior-Radu" maintainer="senarisk@gmail.com"

ENV         DEBIAN_FRONTEND noninteractive

RUN         apt update -y \
            && apt upgrade -y \
            && apt install -y apt-transport-https wget iproute2 \
            && wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
            && dpkg -i packages-microsoft-prod.deb \
            && rm packages-microsoft-prod.deb \
            && apt update -y \
            && apt install -y aspnetcore-runtime-7.0 libgdiplus

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./../entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]