FROM consul

# Set one or more individual labels
LABEL cabify.web.version="0.0.1-beta"
LABEL autor="FranciscoFregona"
LABEL cabify.web.release-date="2018-04-19"
LABEL cabify.web.version.is-production="false"

#Propio de la app de cabify
#Setup previo
RUN apk add --update \
    python \
    # python-dev \
    py-pip \
    # build-base \
  && rm -rf /var/cache/apk/*

#Setup de apps de base
RUN pip install bottle
# RUN pip install gunicorn

EXPOSE 8181
RUN mkdir -p /opt/cabify
COPY cabify.py /opt/cabify

# #Esto no esta funcionando, lo pondremos dentro del docker-entrypoint de consul
# RUN /usr/bin/python /opt/cabify/cabify.py &

#Rip del dockerfile de Consul
# Consul doesn't need root privileges so we run it as the consul user from the
# entry point script. The entry point script also uses dumb-init as the top-level
# process to reap any zombie processes created by Consul sub-processes.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# By default you'll get an insecure single-node development server that stores
# everything in RAM, exposes a web UI and HTTP endpoints, and bootstraps itself.
# Don't use this configuration for production.
CMD ["agent", "-dev", "-client", "0.0.0.0"]


########################################################################
#####Solo a modo de referencia. se va.
# ENV DUMB-INIT_VERSION=1.2.1
# # This is the release of Consul to pull in.
# ENV CONSUL_VERSION=1.0.7
# # This is the location of the releases.
# ENV HASHICORP_RELEASES=https://releases.hashicorp.com

# #FIXME: separadas las instrucciones de apt-get para intentar que cachee
# #con los repos ya actualizados. Volver a unir las instrucciones una vez que
# #esto instale correctamente.
# RUN apt-get update
# RUN apt-get install -y \
#   python-bottle \
#   python-pip \
#   \
#   ca-certificates \ 
#   curl \
#   gnupg \
#   wget \
#   # libcap \
#   # openssl \
#   # su-exec \
# && rm -rf /var/lib/apt/lists/*

# #Dumb-init
# RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v/dumb-init_${DUMB-INIT_VERSION}_amd64
# RUN chmod +x /usr/local/bin/dumb-init

# #Consul
# # Create a consul user and group first so the IDs get set the same way, even as
# # the rest of this may change over time.
# RUN addgroup consul && \
#     adduser --system --group consul

# # Set up certificates, base tools, and Consul.
# RUN gpg --keyserver pgp.mit.edu --recv-keys 91A6E7F85D05C65630BEF18951852D87348FFC4C && \
#     mkdir -p /tmp/build && \
#     cd /tmp/build && \
#     /usr/bin/wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip && \
#     /usr/bin/wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS && \
#     /usr/bin/wget ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS.sig && \
#     gpg --batch --verify consul_${CONSUL_VERSION}_SHA256SUMS.sig consul_${CONSUL_VERSION}_SHA256SUMS && \
#     grep consul_${CONSUL_VERSION}_linux_amd64.zip consul_${CONSUL_VERSION}_SHA256SUMS | sha256sum -c && \
#     unzip -d /bin consul_${CONSUL_VERSION}_linux_amd64.zip

# # The /consul/data dir is used by Consul to store state. The agent will be started
# # with /consul/config as the configuration directory so you can add additional
# # config files in that location.
# RUN mkdir -p /consul/data && \
#     mkdir -p /consul/config && \
#     chown -R consul:consul /consul

# # Expose the consul data directory as a volume since there's mutable state in there.
# VOLUME /consul/data

# # Server RPC is used for communication between Consul clients and servers for internal
# # request forwarding.
# EXPOSE 8300

# # Serf LAN and WAN (WAN is used only by Consul servers) are used for gossip between
# # Consul agents. LAN is within the datacenter and WAN is between just the Consul
# # servers in all datacenters.
# EXPOSE 8301 8301/udp 8302 8302/udp

# # HTTP and DNS (both TCP and UDP) are the primary interfaces that applications
# # use to interact with Consul.
# EXPOSE 8500 8600 8600/udp




# RUN mkdir -p /opt/cabify
# COPY cabify.py /opt/cabify

# EXPOSE 8181

# # COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
# ENTRYPOINT ["/usr/local/dumb-init" "/usr/bin/python", "/opt/cabify/cabify.py", "&"] #,";","consul"

# # By default you'll get an insecure single-node development server that stores
# # everything in RAM, exposes a web UI and HTTP endpoints, and bootstraps itself.
# # Don't use this configuration for production.
# # CMD ["agent", "-dev", "-client", "0.0.0.0"]