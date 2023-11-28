# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

bind '"\C-f":"tmux-sessionizer\n"'
bind '"\C-s":"copyFilePath\n"'
bind '"\es":"copyFilePath recursive\n"'
bind '"\C-g":"gotoDirectFolder\n"'
bind '"\eg":"gotoDirectFolder recursive\n"'

copyFilePath() {
    args=""
    if [ "$1" != "recursive" ]; then
        args+="-maxdepth 1"
    fi
    file=$(find $args | fzf)
    if [ -n "$file" ]; then
        wl-copy $(realpath $file)
    fi
}

gotoDirectFolder() {
    args=""
    if [ "$1" != "recursive" ]; then
        args+="-maxdepth 1"
    fi
    folder=$(find $args -type d | fzf)
    if [ -n "$folder" ]; then
        cd $folder
    fi
}

# User specific environment and startup programs
. "$HOME/.cargo/env"
