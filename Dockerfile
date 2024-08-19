FROM alpine:latest
LABEL MAINTAINER="https://github.com/A-Davil/Xphisher.git"
WORKDIR /Xphisher/
ADD . /Xphisher
RUN apk add --no-cache bash ncurses curl unzip wget php 
CMD "./phishing.sh"
