## A project to boot a docker swarm on a baremetal cluster from a docker container.

TLDR directions:
I recommend trying it out with VMs first, it is possible to change network settings in unexpected ways.
```
make #Builds the docker container
docker run -it --name pxe --rm pxeimage  # Runs the docker image that runs the dhcp server that hands out pxe
sudo brctl addbr docker0 eth0 # eth0 must be the interface connected to the pxe machines.
sudo ifconfig eth0 up #  the physical interface in the bridge must be up.
```

If you run into issues, feel free to create issues on this github repo, or email me!
