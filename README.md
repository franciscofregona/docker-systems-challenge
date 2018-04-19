# docker-systems-challenge

a certain systems challenge for a certain company

## Licencia de uso

Esta prohibido el uso del contenido de este repositorio sin mi consentimiento expreso.
Algunos fragmentos de código son propiedad de la empresa que creó este desafío de sistemas y su uso no será autorizado por mi.

## Decisiones y justificaciones

Enfoque: heredar directamente del contenedor oficial de Consul e instalarle bottle allí.

Lamento no utilizar Ubuntu como contenedor base, pero el oficial de Consul hereda de Alpine y se hace mucho mas sencillo.

Se puede probar hacerlo con Ubuntu, pero seguro el tamaño del contenedor se dispara.

## Fuentes, material de lectura y copipasta.

 * https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#entrypoint
 * HAProxy funciona, NGinx no. https://thehftguy.com/2016/10/03/haproxy-vs-nginx-why-you-should-never-use-nginx-for-load-balancing/
futuro y evolucion de la solucion
 * Consul dockerfile: https://github.com/hashicorp/docker-consul/blob/389ad67978f3fb9c43ae270e31c2d7b121df46c0/0.X/Dockerfile
 * Instalacion de bottle en Alpine: https://hub.docker.com/r/devries/bottle/
 * Swarm con los contenedores balanceados: https://medium.com/@nirgn/load-balancing-applications-with-haproxy-and-docker-d719b7c5b231
 * Puertos en el docker-compose file: https://docs.docker.com/compose/compose-file/#ports
## Contenedores

 * web: contiene la app, el server bottle y el cliente/servidor de Consul.

 ** uso: __TODO__

 El primero se podría ejecutar distinto, para crear un servidor Consul
 
 O crear un servidor consul aparte con el contenedor directamente. 

 * haproxy: Segun el link en medium.com, basta con usar el pre-armado en _dockercloud/haproxy_

## Comandos

Construir el contenedor web con

```bash
time docker build [--no-cache] -t cabifyweb:v1.0 -f dockerimages/web/Dockerfile context/web
```

## Respuestas

__TODO__

