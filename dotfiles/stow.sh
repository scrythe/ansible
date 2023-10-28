#!/usr/bin/env bash

pushd "$HOME/dotfiles"
stowfolders=("nvim" "tmux")
for folder in ${stowfolders[@]}; do
    stow $folder
done
