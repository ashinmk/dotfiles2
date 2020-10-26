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

iterm2_hostname=${HOST}; # Remove if we'll ever start modifying $HOST.
source "${HOME}/.iterm2_shell_integration.zsh"

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

# eval "$(starship init zsh)" ## ORIGINAL

# source <("/usr/local/bin/starship" init zsh --print-full-init)  ## Generated Wrapper
# [[ -f ${HOME}/.starship-init.sh  ]] || (starship init zsh --print-full-init > ${HOME}/.starship-init.sh);
source ${HOME}/.starship-init.sh;

function benchmark_zsh() {
    hyperfine -w 20 -r 50 "zsh -i -c exit;";
}
#source ~/.zsh-prompt-benchmark/zsh-prompt-benchmark.plugin.zsh