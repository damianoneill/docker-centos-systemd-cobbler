# docker-centos-systemd-cobbler
Dockerfile for Cobbler

This leverages [damianoneill:centos-systemd](https://hub.docker.com/r/damianoneill/centos-systemd/).

The Dockerfile installs the EPEL repositories that contain the Cobbler packages we need.

The Dockerfile sets up dhcp, dns, kickstart and Cobbler.

To use the Dockerfile we need to run it in privileged mode, use the hosts network stack and persist the configuration and imported Cobbler OS distributions, so that they are available over restart.
