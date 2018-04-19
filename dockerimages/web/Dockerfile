FROM ubuntu:trusty

# Set one or more individual labels
LABEL cabify.web.version="0.0.1-beta"
LABEL autor="FranciscoFregona"
LABEL cabify.web.release-date="2018-04-19"
LABEL cabify.web.version.is-production="false"

RUN apt-get update && apt-get install -y \
  python-bottle=0.12.13 \
  python-pip \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/cabify
COPY cabify.py /opt/cabify

COPY upstartCabify.conf /etc/init/cabify.conf

EXPOSE 8181

COPY cabify.sh /usr/local/bin
ENTRYPOINT ["cabify.sh"]
CMD ["initctl", "start", "cabify"]