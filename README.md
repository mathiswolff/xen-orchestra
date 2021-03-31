## Install Node.js LTS
```
DISTRO="$(lsb_release -s -c)"
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
echo "deb https://deb.nodesource.com/node_14.x $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs
```

## Install Xen Orchestra
```
DISTRO="$(lsb_release -s -c)"
curl -fsSL https://deb.wolff.tel/apt.gpg | sudo apt-key add -
echo "deb http://deb.wolff.tel/xo $DISTRO main" | sudo tee /etc/apt/sources.list.d/xen-orchestra.list
sudo apt-get update
sudo apt-get install xo-server
```
