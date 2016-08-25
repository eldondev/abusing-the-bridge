docker-image : netboot 
	docker build -t pxeimage .

netboot : initrd2
	grub-mknetdir --net-directory netboot
	cp -v grub.cfg netboot/boot/grub/grub.cfg

initrd2: core-login-key docker112
	find usr/ |cpio -o  -H newc -O initrd2

docker112:
	rm -rf usr/share/oem/docker-1.12.1.tgz
	wget -P usr/share/oem/  http://get.docker.com/builds/Linux/x86_64/docker-1.12.1.tgz

core-login-key: swarm
	rm -f core-login-key
	ssh-keygen -N "" -f core-login-key
	mkdir -p usr/share/oem
	sed "s%SSHKEY%`cat core-login-key.pub`%" cloud-config.yml >usr/share/oem/cloud-config.yml
	echo -n /opt/docker/ >>usr/share/oem/cloud-config.yml
	docker swarm join-token worker |tail -n +2 | cut -c 5- >>usr/share/oem/cloud-config.yml
	cp -v docker.service usr/share/oem/

swarm: PHONY
	docker swarm init --advertise-addr 172.17.0.1 || true

PHONY:
