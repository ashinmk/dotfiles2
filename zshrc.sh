LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

source "${HOME}/.homebrew_init"

export PATH="${HOME}/Scripts/bin:${HOME}/.toolbox/bin:$PATH"

setopt AUTOCD                     # Giving a dir makes it cd to the same
setopt CLOBBER                    # Enables piping to existing files without warning
setopt INTERACTIVE_COMMENTS       # Allow comments in shell
setopt RMSTARSILENT               # Don't give warnings when doing rm

setopt EXTENDED_HISTORY           # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST     # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_ALL_DUPS       # remove older duplicate entries from history
setopt HIST_IGNORE_SPACE          # Do not record an event starting with a space.
setopt HIST_REDUCE_BLANKS         # remove superfluous blanks from history items
setopt HIST_SAVE_NO_DUPS          # Do not write a duplicate event to the history file.
setopt INC_APPEND_HISTORY         # save history entries as soon as they are entered
setopt SHARE_HISTORY              # share history between different instances of the shell

HISTFILE="${HISTFILE:-${ZDOTDIR:-$HOME}/.zhistory}"  # The path to the history file.
HISTSIZE=100000                   # The maximum number of events to save in the internal history.
SAVEHIST=100000                   # The maximum number of events to save in the history file.


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