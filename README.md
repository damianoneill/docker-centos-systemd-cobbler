# docker-centos-systemd-cobbler
Dockerfile for Cobbler

This leverages [damianoneill/centos-systemd](https://hub.docker.com/r/damianoneill/centos-systemd/).

The Dockerfile installs the EPEL repositories that contain the Cobbler packages we need.

The Dockerfile sets up dhcp, dns, kickstart and Cobbler.

To build the image run the following command.

     $ docker build -t cobbler .

To use the Dockerfile we need to run it in privileged mode, use the hosts network stack and persist the configuration and imported Cobbler OS distributions, so that they are available over restart.

To persist the initial configuration start a container, copy the config files to host, close the container down.

     $ docker run -d --name cobbler cobbler; docker cp cobbler:/etc/cobbler etc; docker stop cobbler; docker rm cobbler

At this point all the base configuration will be in etc/cobbler.

Read the Cobbler quickstart for full details http://cobbler.github.io/manuals/quickstart/

Then do the following in the Cobbler configuration:
* Update the default root password
* Setup the server and next_server values
* Enable dhcp and dns

This configuration can be summarized by running

```bash
# cobbler check
The following are potential configuration items that you may want to fix:

1 : The 'server' field in /etc/cobbler/settings must be set to something other than localhost, or kickstarting features will not work.  This should be a resolvable hostname or IP for the boot server as reachable by all machines that will use it.
2 : For PXE to be functional, the 'next_server' field in /etc/cobbler/settings must be set to something other than 127.0.0.1, and should match the IP of the boot server on the PXE network.
3 : some network boot-loaders are missing from /var/lib/cobbler/loaders, you may run 'cobbler get-loaders' to download them, or, if you only want to handle x86/x86_64 netbooting, you may ensure that you have installed a *recent* version of the syslinux package installed and can ignore this message entirely.  Files in this directory, should you want to support all architectures, should include pxelinux.0, menu.c32, elilo.efi, and yaboot. The 'cobbler get-loaders' command is the easiest way to resolve these requirements.
4 : Neither wget nor curl are installed and/or available in $PATH. Cobbler requires that one of these utilities be installed.
5 : enable and start rsyncd.service with systemctl
6 : debmirror package is not installed, it will be required to manage debian deployments and repositories
7 : The default password used by the sample templates for newly installed machines (default_password_crypted in /etc/cobbler/settings) is still set to 'cobbler' and should be changed, try: "openssl passwd -1 -salt 'random-phrase-here' 'your-password-here'" to generate new one
8 : fencing tools were not found, and are required to use the (optional) power management features. install cman or fence-agents to use them

Restart cobblerd and then run 'cobbler sync' to apply changes.
```


At this point Cobbler can now be used to configure systems.

https://server_ip/cobbler_web/
