#!/usr/bin/env bash

rm ~/.bash_profile
pushd "$HOME/dotfiles"
stowfolders=("nvim" "tmux" "bin" "bash")
for folder in ${stowfolders[@]}; do
    stow $folder
done
