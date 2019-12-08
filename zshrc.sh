LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

if [[ "$OSTYPE" == darwin* ]]; then
    PATH="$PATH:/Users/gauthamw/Scripts/bin"
else
     eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi
export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:$HOME/.toolbox/bin:$PATH"

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
# source ~/.zsh-defer/zsh-defer.plugin.zsh

setopt clobber              # Enables piping to existing files without warning
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks   # remove superfluous blanks from history items
setopt inc_append_history   # save history entries as soon as they are entered
setopt share_history        # share history between different instances of the shell
setopt autocd               # Giving a dir makes it cd to the same
setopt rmstarsilent

autoload -U promptinit
promptinit

source "${HOME}/.iterm2_shell_integration.zsh"

autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

alias bb="brazil-build"
unalias rm 2>/dev/null

. /usr/local/etc/profile.d/z.sh

for initFile in $HOME/.dotconfig/*/init.sh; do
    source "$initFile"
done

for initFile in $HOME/.amazon.ext.dotconfig/*/init.sh; do
    source "$initFile"
done

#for deferredInitFile in $HOME/.dotconfig/*/init.defer.sh; do
#    echo "$deferredInitFile";
#    zsh-defer source "$deferredInitFile"
#done

for aliasFile in $HOME/.dotconfig/*/aliases.sh; do
    source "$aliasFile"
done

source ~/.powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source ~/.p10k.zsh

function benchmark_zsh() {
    for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
}
