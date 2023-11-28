#!/usr/bin/env bash

pushd "$HOME/dotfiles"
stowfolders=("nvim" "tmux" "bin" "bash")
for folder in ${stowfolders[@]}; do
    stow $folder
done
