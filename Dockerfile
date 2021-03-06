FROM damianoneill/centos-systemd
RUN yum -y install epel-release
RUN yum -y install cobbler cobbler-web dhcp bind syslinux pykickstart wget

RUN systemctl enable cobblerd
RUN systemctl enable httpd
RUN systemctl enable dhcpd
RUN systemctl enable named

# enable tftp
RUN sed -i -e 's/\(^.*disable.*=\) yes/\1 no/' /etc/xinetd.d/tftp

# create rsync file
RUN touch /etc/xinetd.d/rsync

EXPOSE 53
EXPOSE 68
EXPOSE 69
EXPOSE 80
EXPOSE 25151

CMD ["/sbin/init"]
