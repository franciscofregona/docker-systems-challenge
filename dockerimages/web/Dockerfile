FROM ubuntu:trusty

# Set one or more individual labels
LABEL cabify.web.version="0.0.1-beta"
LABEL autor="FranciscoFregona"
LABEL cabify.web.release-date="2018-04-19"
LABEL cabify.web.version.is-production="false"

#FIXME: separadas las instrucciones de apt-get para intentar que cachee
#con los repos ya actualizados. Volver a unir las instrucciones una vez que
#esto instale correctamente.
RUN apt-get update
RUN apt-get install -y \
  python-bottle \
  python-pip \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/cabify
COPY cabify.py /opt/cabify

EXPOSE 8181

ENTRYPOINT ["/usr/bin/python", "/opt/cabify/cabify.py"]
