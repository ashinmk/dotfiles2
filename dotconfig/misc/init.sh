function zle-reload-zsh() {
    source $HOME/.zshrc;
    zle accept-line;
}

zle -N zle-reload-zsh;
bindkey '\eR\eR' zle-reload-zsh;

function benchmark_zsh() {
    hyperfine -w 20 -r 50 "zsh -i -c exit;";
}

zinit wait lucid light-mode for romkatv/zsh-prompt-benchmark