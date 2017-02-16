#!/bin/bash
# filename: install.sh
set -euxo pipefail

#download Docker container image
docker pull j0rg3/wickr         

# make directory for SSH keys
# nothing will happen if directory already exists
mkdir -p ~/.config/wickr/keys

# generate keys for SSH
cd ~/.config/wickr/keys
ssh-keygen -b 4096 -P "" -C $"$(whoami)@$(hostname)-$(date -I)" -f docker-wickr-keys

# link so Docker container will see as pubkey
ln -fs docker-wickr-keys.pub authorized_keys

# link to Wickr script for system-wide access
ln -fs ~/wickr/wickr /usr/local/bin/wickr


