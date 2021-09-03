declare -a autojump_paths
autojump_paths=(
    $HOME/.autojump/etc/profile.d/autojump.zsh         # manual installation
    $HOME/.autojump/share/autojump/autojump.zsh        # manual installation
    $HOME/.nix-profile/etc/profile.d/autojump.sh       # NixOS installation
    /run/current-system/sw/share/autojump/autojump.zsh # NixOS installation
    /usr/share/autojump/autojump.zsh                   # Debian and Ubuntu package
    /etc/profile.d/autojump.zsh                        # manual installation
    /etc/profile.d/autojump.sh                         # Gentoo installation
    /usr/local/share/autojump/autojump.zsh             # FreeBSD installation
    /opt/local/etc/profile.d/autojump.sh               # macOS with MacPorts
    /usr/local/etc/profile.d/autojump.sh               # macOS with Homebrew (default)
)

foo() {
    for aj_file in $autojump_paths; do
        if [[ -f "$aj_file" ]]; then
            source "$aj_file"
            found=1
            break
        fi
    done

    # if no path found, try Homebrew
    if ((!found && $ + commands[brew])); then
        aj_file=$(brew --prefix)/etc/profile.d/autojump.sh
        if [[ -f "$aj_file" ]]; then
            source "$aj_file"
            found=1
        fi
    fi

    ((!found)) && echo '[oh-my-zsh] autojump not found. Please install it first.'
}

foo

unset autojump_paths file found
