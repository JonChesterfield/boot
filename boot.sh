#!/usr/bin/env bash

set -e
set -o pipefail
set -x

mkdir -p ~/.ssh

if [[ -f ~/.ssh/id_rsa ]]
then
    echo "~/.ssh/id_rsa already exists"
else
    ssh-keygen -f ~/.ssh/id_rsa -t rsa -b 4096 -C `hostname` -N ""
fi

if [[ -f ~/.ssh/github_id_rsa ]]
then
    echo "~/.ssh/github_id_rsa already exists"
else
    ssh-keygen -f ~/.ssh/github_id_rsa -t rsa -b 4096 -C "github-`hostname`" -N ""
fi

cat << EOF > ~/.ssh/config
Include ~/.ssh/config.local

Compression yes
IdentitiesOnly yes
ForwardAgent no
ServerAliveInterval 60
ServerAliveCountMax 10

EOF

touch ~/.ssh/authorized_keys
chmod 644 ~/.ssh/authorized_keys

# Otherwise git ignores the github key
# This will be somewhat annoying when cloning from another server
git config --global core.sshCommand 'ssh -i ~/.ssh/github_id_rsa'

exit 0
