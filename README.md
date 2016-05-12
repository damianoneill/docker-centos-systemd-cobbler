# docker-centos-systemd-cobbler
Dockerfile for Cobbler

This leverages [damianoneill/centos-systemd](https://hub.docker.com/r/damianoneill/centos-systemd/).

The Dockerfile installs the EPEL repositories that contain the Cobbler packages we need.

The Dockerfile sets up dhcp, dns, kickstart and Cobbler.

To build the image run the following command.

     $ docker build -t cobbler .

To use the Dockerfile we need to run it in privileged mode, use the hosts network stack and persist the configuration and imported Cobbler OS distributions, so that they are available over restart.

To persist the initial configuration start a container, copy the config files to host, close the container down.

     $ docker run -d --name cobbler cobbler; docker cp cobbler:/etc/cobbler/settings etc/cobbler/; docker cp cobbler:/etc/cobbler/dhcp.template etc/cobbler/; docker stop cobbler; docker rm cobbler

At this point there will be two files in etc/cobbler; settings and dhcp.template.  Both of these need updates.

 
