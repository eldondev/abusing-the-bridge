FROM busybox
ADD netboot /tftpdir/
ADD http://alpha.release.core-os.net/amd64-usr/current/coreos_production_pxe.vmlinuz /tftpdir/vmlinuz
ADD http://alpha.release.core-os.net/amd64-usr/current/coreos_production_pxe_image.cpio.gz /tftpdir/initrd1
ADD tftp /init/tftp/run
ADD udhcpd /init/udhcpd
RUN mkdir -p /var/lib/misc
RUN touch /var/lib/misc/udhcpd.leases
CMD runsvdir /init
