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

# Otherwise git ignores the github key
# This will be somewhat annoying when cloning from another server
git config --global core.sshCommand 'ssh -i ~/.ssh/github_id_rsa'

exit 0
