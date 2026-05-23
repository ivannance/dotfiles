#!/bin/bash
set -e

echo "Setting up SSH..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cp ssh_config ~/.ssh/config
chmod 600 ~/.ssh/config

echo "Setting up git..."
cp gitconfig ~/.gitconfig

echo "Done. Add your SSH key to the home server:"
echo "ssh-copy-id -p 2222 ivan@ivans.world"
