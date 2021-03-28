# Instructions:
### Install VirtualBox
### Install docker-machine
### Install VirtualBox extension pack

## docker-machine:

### create and start the machine
```
docker-machine create -d virtualbox default
```
### We must stop the machine in order to modify some settings
```
docker-machine stop
```
### Enable USB 2.0 (requires VirtualBox extension pack)
```
vboxmanage modifyvm default --usb on
vboxmanage modifyvm default --usbehci on
```
# Find details of your PICkit to create a USB filter
```
vboxmanage list usbhost
```
### Setup a usb filter so your device automatically gets connected to the Virtualbox VM.
```
vboxmanage usbfilter add 0 --target default --name  "PICkit 2" --vendorid 0x04d8 --productid 0x0033 --remote no
```
### mount MPLABXProjects on the default docker machine
```
vboxmanage sharedfolder add default -hostpath $HOME/MPLABXProjects/ --name MPLABXProjects -automount --auto-mount-point "/"
```
### Go ahead and start the VM back up
```
docker-machine start
```
### setup your terminal to use your new docker-machine
### (you must do this every time you want to use this docker-machine or add it to your .bash_profile)
```
eval $(docker-machine env default)
```
### ssh into the docker-machine and find out where the PICkit shows up in /dev (mine was `/dev/bus/usb/002/004`)
```
docker-machine ssh 
ls -al /dev/bus/usb/
``` 
## docker:
### Build image
```
docker build -t pkcmd-lx_debian .
```
### Start container
```
docker run -t -d -v /MPLABXProjects:/app/MPLABXProjects --device /dev/bus/usb/ pkcmd-lx_debian 
```
### List containers
```
docker ps
```
### Access the container 
```
docker exec -it <container_name>  /bin/bash
```
### run pkcmd-lx
```
root@<CONTAINER_ID>:/app# ./pkcmd-lx-x86_64 --help

PKCMD-LX 4.06
A program for interfacing with the PICkit2 and PICkit3 microcontroller programmers
Product licensed to *****

Looking for tools...

   Found PK2 "?"

Found 1 tool
```
