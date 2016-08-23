docker-image : netboot 
	docker build -t pxeimage .

netboot : initrd2
	grub-mknetdir --net-directory netboot
	cp -v grub.cfg netboot/boot/grub/grub.cfg

initrd2: core-login-key
	find usr/ |cpio -o  -H newc -O initrd2

core-login-key: cloud-config.yml
	ssh-keygen -N "" -f core-login-key
	sed "s%SSHKEY%`cat core-login-key.pub`%" cloud-config.yml >usr/share/oem/cloud-config.yml
	
