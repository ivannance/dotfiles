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

echo "Checking for SSH key..."
if [ ! -f ~/.ssh/id_ed25519 ]; then
  echo "No SSH key found, generating one..."
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
fi

echo "Adding SSH key to home server..."
ssh-copy-id -p 2222 ivan@ivans.world

echo "Adding SSH key to VPS via homeserver..."
cat ~/.ssh/id_ed25519.pub | ssh homeserver "ssh root@192.3.16.75 'cat >> ~/.ssh/authorized_keys'"

echo "Done! All set up."
