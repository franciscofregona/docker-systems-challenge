FROM consul

LABEL cabify.consulserver.version="1.0"
LABEL autor="FranciscoFregona"
LABEL cabify.consulserver.release-date="2018-04-19"
LABEL cabify.consulserver.version.is-production="false"

#Riped from Consul's dockerfile. Modified docker-entrypoint.sh.
# Consul doesn't need root privileges so we run it as the consul user from the
# entry point script. The entry point script also uses dumb-init as the top-level
# process to reap any zombie processes created by Consul sub-processes.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# By default you'll get an insecure single-node development server that stores
# everything in RAM, exposes a web UI and HTTP endpoints, and bootstraps itself.
# Don't use this configuration for production.
CMD ["agent", "-dev", "-server"] #, "0.0.0.0"]