# docker-systems-challenge
a certain systems challenge for a certain company

#Licencia de uso
Esta prohibido el uso del contenido de este repositorio sin mi consentimiento expreso.
Algunos fragmentos de código son propiedad de la empresa que creó este desafío de sistemas y su uso no será autorizado por mi.

#Decisiones y justificaciones
##Ubuntu
Puesto que en el posting para la vacante mencionaron que utilizan Ubuntu, utilizaré eso como base para los contenedores.

Puesto que ya cuento con el codigo ansible que configura una vm de Vagrant, bien puedo utilizarlo para generar el contenedor.
Suena un poco a trampa pero creo sería a la larga la solucin que pide este challenge. Suena razonable pensar que una empresa tiene automatizado el despliegue de nuevos contenedores con el toolchain de Ansible, que es muy completo (y para colmo el challenge mismo configura la vm con Ansible!)
En una segunda respuesta, exploraré la opción de crear los contenedores con ansible-container.

Pero primero: un dockerfile - reescribir el código de Ansible en un dockerfile.
Luego, para tener balanceo de carga, confiaremos en docker-compose.

#Fuentes, material de lectura y copipasta.
 * https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#entrypoint
 * HAProxy funciona, NGinx no. https://thehftguy.com/2016/10/03/haproxy-vs-nginx-why-you-should-never-use-nginx-for-load-balancing/
futuro y evolucion de la solucion
 * Consul dockerfile: https://github.com/hashicorp/docker-consul/blob/389ad67978f3fb9c43ae270e31c2d7b121df46c0/0.X/Dockerfile

#Respuestas
__TODO__

