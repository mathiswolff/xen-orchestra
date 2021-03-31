Allows you to use Xen Orchestra (Community Edition) if you don't want to use the Appliance or build from sources manually. 


# Installation
## Install Node.js LTS
```
DISTRO="$(lsb_release -s -c)"
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
echo "deb https://deb.nodesource.com/node_14.x $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs
```

## Install Xen Orchestra
Packages compatible with Debian 10 (Buster)
```
DISTRO="$(lsb_release -s -c)"
curl -fsSL https://deb.wolff.tel/apt.gpg | sudo apt-key add -
echo "deb http://deb.wolff.tel/xo $DISTRO main" | sudo tee /etc/apt/sources.list.d/xen-orchestra.list
sudo apt-get update
sudo apt-get install redis-server xo-server
```

Server will be listening on port 8080. You can login with user `admin@admin.net` and password `admin`.  
To configure a reverse proxy: https://vates.gitbooks.io/xen-orchestra/content/reverse_proxy.html  
Edit config file /etc/xo-server/config.toml if needed.
