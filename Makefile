docker-image : netboot 
	docker build -t pxeimage .
netboot : core-login-key.pub
	grub-mknetdir --net-directory netboot
	cp -v grub.cfg netboot/boot/grub/grub.cfg

core-login-key.pub:
	ssh-keygen -N "" -f core-login-key
	
