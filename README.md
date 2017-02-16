# georgeglarson/docker-bitmessage-gui 
 [![Docker Pulls](https://img.shields.io/docker/pulls/j0rg3/wickr.svg)](https://hub.docker.com/r/j0rg3/wickr)


# Wickr in a Docker container

- [Introduction](#introduction)
- [Installation](#installation)
- [Notes](#notes)
- [References](#references)


# Introduction
The purpose of this project is to make Wickr available on a system, through a [Docker](https://www.docker.com/) container, with the fluidity of applications natively installed.

A description of how and why this project came to be can be found at [`j0rg3.com`](http://j0rg3.com/2017/02/18#20170218.making.a.docker.wickr).

# Installation
```bash
git clone https://github.com/georgeglarson/wickr 

cd docker-wickr

./install.sh
```

The installation script will:
- pull Docker image
- make local directories
- generate SSH keys
- create symbolic links

Alternatively, you can execute the commands yourself:
```bash
# open Docker container: 
#    detatched, interactive, pseudo-tty (-dit)
#  record container ID in $DID (Docker ID)
DID=$(docker run -v ~/.config/wickr/keys/:/root/.ssh/ -dit j0rg3/wickr bash)

# find IP address of new container, record in $DIP (Docker IP)
DIP=$(docker inspect $DID | grep IPAddress | cut -d '"' -f 4)

# pause for one second to allow container's SSHD to come online
sleep 1

# SSH into container and execute Wickr
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oIdentityFile=~/.config/wickr/keys/docker-wickr-keys -X $DIP wickr-me

# close container if Wickr is closed; must logout first
docker kill $DID
```

# Notes
The commands contained in the 'wickr' script:
```bash
DID=$(docker run -v ~/.config/wickr/keys/:/root/.ssh/ -dit j0rg3/wickr bash) && \
DIP=$(docker inspect $DID | grep IPAddress | cut -d '"' -f 4) && \ 
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oIdentityFile=~/.config/wickr/keys/docker-wickr-keys -X $DIP wickr-me && \
docker kill $DID
```

# References
[http://j0rg3.com/2017/02/18#20170218.making.a.docker.bitmessage](http://j0rg3.com/2017/02/18#20170218.making.a.docker.bitmessage)



