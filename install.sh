#!/bin/bash
set -e

echo "Setting up SSH..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cp ssh_config ~/.ssh/config
chmod 600 ~/.ssh/config

echo "Setting up git..."
mkdir -p ~/.config/git
cp gitconfig ~/.config/git/config

echo "Setting up fish functions..."
mkdir -p ~/.config/fish/functions
cp -r fish_functions/* ~/.config/fish/functions/

echo "Done. Add your SSH key to the home server and vps:"
echo "ssh-copy-id -p 2222 ivan@ivans.world"
echo "ssh-copy-id vps"
