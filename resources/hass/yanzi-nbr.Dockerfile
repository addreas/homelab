FROM ubuntu
RUN apt-get update -y && apt-get install -y net-tools && apt-get clean
