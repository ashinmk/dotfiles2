LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

source "${HOME}/.homebrew_init"

export PATH="${HOME}/Scripts/bin:${HOME}/.toolbox/bin:$PATH"

setopt clobber              # Enables piping to existing files without warning
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks   # remove superfluous blanks from history items
setopt inc_append_history   # save history entries as soon as they are entered
setopt share_history        # share history between different instances of the shell
setopt autocd               # Giving a dir makes it cd to the same
setopt rmstarsilent

autoload -Uz compinit
_comp_files=(${ZDOTDIR:-$HOME}/.zcompdump(Nm-20))
if (( $#_comp_files )); then
  compinit -i -C
else
  compinit -i
fi
unset _comp_files

source "${HOME}/.iterm2_shell_integration.zsh"

autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word

source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

alias bb="brazil-build"

for initFile in $HOME/.dotconfig/*/init.sh; do
    source "$initFile"
done

for initFile in $HOME/.amazon.ext.dotconfig/*/init.sh; do
    source "$initFile"
done

for aliasFile in $HOME/.dotconfig/*/aliases.sh; do
    source "$aliasFile"
done

eval "$(starship init zsh)"

function benchmark_zsh() {
    hyperfine -w 3 "zsh -i -c exit;";
}