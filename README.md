# Debian packages for Xen Orchestra
Allows you to use Xen Orchestra (Community Edition) if you don't want to use the Appliance or build from sources manually.
Using the repository no compiling is needed, so even a VM with 2 GB RAM will be sufficent for operation. Simply install a Debian package.

# Installation
## (Prerequisite) Install Node.js LTS
(Taken from https://github.com/nodesource/distributions/blob/master/README.md#debmanual)  
Execute the following steps to install Node.js:
```
VERSION=node_18.x
KEYRING=/usr/share/keyrings/nodesource.gpg
DISTRO="$(lsb_release -s -c)"
echo "deb [signed-by=$KEYRING] https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs
```

## Install Xen Orchestra
Execute the following steps to configure the repository and install Xen Orchestra:
```
curl -fsSL http://deb.wolff.tel/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/wolff.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/wolff.gpg] http://deb.wolff.tel/xo $(lsb_release -s -c) main" | sudo tee /etc/apt/sources.list.d/xen-orchestra.list
sudo apt-get update
sudo apt-get install redis-server xo-server
```

Server will be listening on port 8080. Open http://\<yourip\>:8080/ and login with user `admin@admin.net` and password `admin`.  
To configure a reverse proxy: https://vates.gitbooks.io/xen-orchestra/content/reverse_proxy.html  
Edit config file /etc/xo-server/config.toml if needed.
