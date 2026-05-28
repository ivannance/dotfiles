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

echo "Updating fish functions..."
mkdir -p ~/.config/fish/functions
rm -f ~/.config/fish/functions/*
if [ -d "fish_functions" ]; then
  cp -r fish_functions/* ~/.config/fish/functions/
  echo "Fish functions synchronized successfully."
fi

echo "Checking for SSH key..."
if [ ! -f ~/.ssh/id_ed25519 ]; then
  echo "No SSH key found, generating one..."
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
fi

export SSH_CONFIG_FILE="$HOME/.ssh/config"

echo "Adding SSH key to mini home server..."
ssh-copy-id mini

echo "Adding SSH key to home PC..."
ssh-copy-id pc

echo "Adding SSH key to laptop..."
ssh-copy-id laptop

echo "Adding SSH key to VPS via mini..."
cat ~/.ssh/id_ed25519.pub | ssh mini "ssh root@192.3.16.75 'cat >> ~/.ssh/authorized_keys'"

echo "Setting fish as default shell..."
FISH_PATH=$(which fish)
if [ -n "$FISH_PATH" ]; then
  if ! grep -q "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
  fi
  if [ "$SHELL" != "$FISH_PATH" ]; then
    chsh -s "$FISH_PATH"
    echo "Fish set as default shell. Takes effect on next login."
  else
    echo "Fish is already the default shell."
  fi
fi

echo "Done! Configuration setup complete."
