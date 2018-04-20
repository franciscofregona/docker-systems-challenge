# docker-systems-challenge

a certain systems challenge for a certain company

## Use License

The use of the contents of this repository is forbidden without my express consent.
Some fragments of the code listed here are property of the company who created it and, therefore, can't be authorized at all.

## Decisions and design choices

### Base Container: Alpine

I regret not using Ubuntu as the base container, but the oficial Consul container inherits from Alpine, and it is therefore much simpler to modify it and take it from there. Of course it can be done in Ubuntu, but I'm sure the size of the resulting container spikes up.

### Service Containers
Web Servers: I inherit from Consul's oficial container and install bottle on it. Afterwards, I modify the docker-entrypoint.sh script to both run the bottle web-server in the background and to launch the Consul client in client mode.

Aditional Consul Server: I add as a dependency an aditional Consul container that will work as a Server. It will offer a stable point of contact with the Consul cluster, so every Web Server can be launched as a client to it.

HAProxy Server: in a separate container. Dockers own version, as it is simpler to configure, per https://medium.com/@nirgn/load-balancing-applications-with-haproxy-and-docker-d719b7c5b231

### Consul Server and Clients Interaction
A problem that spawns from this solution is the direct dependency between this components: if no volume is created, and the server does not get to save it's IP address in a file, no clients can be spawned successfully.
I'm sorry I have not been able to create a more elegant and correct solution. Many thigs were tested but my knowledge of the product is not good enough to craft something better in such short time. This issues come from:
 * Docker Swarm simply won't support the _ipv4_address_ stanza, and
 * Had some trouble launching the container with a command of _consul join server_ form, trusting in Dockers name resolution simply would'nt work(!)

So: Consul server outputs it's IP Address in a file, shared in the _consulserver.d_ volume. The clients load it and use that information to contact it. Messy but it works.

## Resources, Reading material, Copipasta
 * [Entrypoint usage](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#entrypoint)
 * [Balancer: HAProxy works. NGinx does not](https://thehftguy.com/2016/10/03/haproxy-vs-nginx-why-you-should-never-use-nginx-for-load-balancing/)
 * [Consul dockerfile](https://github.com/hashicorp/docker-consul/blob/389ad67978f3fb9c43ae270e31c2d7b121df46c0/0.X/Dockerfile)
 * [Bottle installation in Alpine](https://hub.docker.com/r/devries/bottle/)
 * [Balancing Containers in Swarm](https://medium.com/@nirgn/load-balancing-applications-with-haproxy-and-docker-d719b7c5b231)
 * [Ports in the docker-compose file](https://docs.docker.com/compose/compose-file/#ports)
 * Won't work: ~~~[Fixed IP for a service on a Swarm compose-file](https://github.com/moby/moby/issues/24170#issuecomment-339275174)~~~
 * [HAProxy redundancy: keepalived](http://www.formilux.org/archives/haproxy/1003/3259.html)
## Containers
 * cabifyweb: bottle w/app, Consul client.
 * consulserver: Consul, twisted to auto create.
 * haproxy: balancer.
## Commands and Usage of this material
HAProxy needs not to be built, as it is taken as is from its repos.
Build the Web Container with:
```bash
time docker build [--no-cache] -t cabifyweb:v1.0 -f dockerimages/web/Dockerfile context/web
```
Build the Consul Server container with
```bash
time docker build [--no-cache] -t consulserver:v1.0 -f dockerimages/consulserver/Dockerfile context/consulservercontext/web
```
Initialize the swarm on the host with
```bash
docker swarm init
```
(This command outputs tokens for other servers to join as workers or managers, needed to conform a cluster.)

Create the stack with:
```bash
docker stack deploy -c docker-compose.yml cabifyAppStack
```
## TODO
* Consul (both server and client) is running in _dev_ mode. It is neither writing nor reading from disk, which is the easiest mode for developing the solution. In order to be production ready, it needs to be taken out of -dev mode.
* Also: there are no metrics taken nor services monitored with it, besides the alive/dead test.
* I hard-coded the options for the web and consul server containers in the docker-entrypoint.sh files. A much more clear way would be to keep them as is instead and move the running options into the docker-compose.yml file.
* Finally: I seem to be having some trouble keeping the 8500 port open both for the clients and for myself to monitor. Some reading ahead.

## Answers to the proposed questions
### Identify the SPOFs in the result of the assignment and explain how you would solve them.
The first POF on the solution provided is HAProxy. Beneath it, service workers (bottle app) are redundant.

A very good way to provide redundancy to this service is to spawn more than one HAProxy service, within a __keepalived__ solution. [This message board post](http://www.formilux.org/archives/haproxy/1003/3259.html) offers some insight on the matter, here's a [sample configuration](https://andyleonard.com/2011/02/01/haproxy-and-keepalived-example-configuration/) explained and, finally, [this Docker Container](https://github.com/edwardluzi/docker-keepalived-haproxy) implements it. Or at least it offers a good place to start toying with it.

The Docker Swarm offers (along with the HAProxy balancer) offers protection towards computing failure of the worker nodes. Adding workers to the Swarm increases both the protection towards such failures AND increases the load capacity of the cluster. Both hardware and networking failures are to be covered with this approach.

The next POF to be analized is the name resolution for the service, which in the scenario of being taken care in-house, must be redundant as well.

### Explain how would you upgrade the Cabify service without downtime.
We would like to have a short term solution, something that in the real world you would be able to deliver the same day or week. Then provide an explanation for a more complex solution where you improve the state of this assignment to your ideal release management process.
____Upgrading in working capacity, short term:____
Adding cluster working nodes to the Swarm will improve its capacity. As per [Docker's official documentation](https://docs.docker.com/engine/swarm/swarm-tutorial/add-nodes/), the command needed is __docker swarm join__, along with the token for the cluster, either for a worker or a manager node.

Adding working nodes (web server containers, within the cluster actual capacity) would involve the use of the comand __docker service scale SERVICE=REPLICAS__, as per [Docker's official documentation](https://docs.docker.com/engine/reference/commandline/service_scale/), where __service__ stands for the name used in the entries in the service stanza in the _docker-compose.yml_ file.

__Upgrading of the solution, mid term: tooling and code__
* First and foremost: if there is much more Ansible code within the tooling, I'd seriously consider something along the lines of [ansible-container](https://www.ansible.com/integrations/containers/ansible-container). I actually started to tackle this challenge with it but ran into issues I could not solve. Being able to re-use the codebase with no re-writing (which I had to do... bah, more like re-interpreting of the function of the roles into containers) is too good to pass.
* My version of the solution needs some CI tooling. I think it is fine for an exercise or training in Docker, but in order to be able to scale up and out, I'd:
** Invest in Jenkins (or TravisCI or other CI tools) as a way to automate the process. Perhaps as a container in another stack.
** Invest in automated testing of the solution, to keep at a minimum the issues and bugs. This would be launched by Jenkins after every commit to the codebase.
** Add a Nomad container as means of service migration, specially if multiple cloud vendors are needed to provide redundancy. (Terraform comes in handy!)
** Monitoring: I favor the Graphite/Grafana stack for some fancy graphs and metrics.
 
__Upgrading of the solution, long term__
Once the tooling is set for it, I think that in order to maintain scalability one would need to rely on the tooling provided by [a cloud vendor](https://aws.amazon.com/autoscaling/), [or another](https://cloud.google.com/compute/docs/autoscaler/), [or another](https://azure.microsoft.com/en-us/features/autoscale/), to scale up the cluster, instead of manually adding workers and increasing the number of web-servers (and database!)

The ideal release process for this application would be along the lines of:
Developers push new code into the codebase repository.
Jenkins takes notices of this and launches automated testing on it. If the code will play along with other existing components, it gets pushed into the cluster, for it to be rolled in. The best way for this would be with the aid of the balancer: no user would see downtime, yet new arriving users would see the updated artifact.
As users come in and go, the solution gets monitored and anomalies get reported. Metrics on the state of the solution trigger the cloud vendor scaling tools.

Thanks for reading!