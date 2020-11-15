function zle-reload-zsh() {
    source $HOME/.zshrc;
    zle accept-line;
}

zle -N zle-reload-zsh;
bindkey '\eR\eR' zle-reload-zsh;