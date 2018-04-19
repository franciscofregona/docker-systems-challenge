FROM ubuntu:trusty

# Set one or more individual labels
LABEL com.example.version="0.0.1-beta"
LABEL vendor="ACME Incorporated"
LABEL com.example.release-date="2015-02-12"
LABEL com.example.version.is-production=""

RUN apt-get update && apt-get install -y \
  python-bottle==0.12.13 \
  python-pip \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/cabify
COPY cabify.py /opt/cabify

COPY upstartCabify.conf /etc/init/cabify.conf

EXPOSE 8181

COPY cabify.sh /usr/local/bin
ENTRYPOINT ["cabify.sh"]
CMD ["initctl", "start", "cabify"]