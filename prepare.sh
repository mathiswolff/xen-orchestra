#!/bin/sh

apt-get update
apt-get install -qy --no-install-recommends build-essential devscripts debhelper libdistro-info-perl rclone libpng-dev python3-minimal libvhdi-utils lvm2 cifs-utils curl qemu-utils python3-vmdkstream git libxml2-utils libfuse2 nbdkit
