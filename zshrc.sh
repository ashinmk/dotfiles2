export PATH="${HOME}/Scripts/bin:${HOME}/.toolbox/bin:$PATH"

source "$HOME/.dotconfig/early-env-setup/zsh-opts.sh";

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

source "$HOME/.dotconfig/early-env-setup/brew-env-setup.sh";

zinit wait lucid light-mode for \
    atinit='zicompinit; zicdreplay' zdharma/fast-syntax-highlighting \
    atload='_zsh_autosuggest_start' zsh-users/zsh-autosuggestions \
    blockf atpull='zinit creinstall -q .' zsh-users/zsh-completions


export BRAZIL_WS_DIR="/ws";

zinit wait lucid light-mode for atload='zsh-defer source "${HOME}/.dotconfig/lazy-init.sh"' romkatv/zsh-defer

zinit wait lucid for id-as="iterm2-shell-integration" pick=".iterm2_shell_integration.zsh" "${HOME}";

for initFile in $HOME/.dotconfig/*/init.sh; do
    source "$initFile"
done

for initFile in $HOME/.amazon.ext.dotconfig/*/init.sh; do
    source "$initFile"
done

for aliasFile in $HOME/.dotconfig/*/aliases.sh; do
    source "$aliasFile"
done

zinit light-mode for pick="$HOME/.dotconfig/p10k/p10k.zsh" src="powerlevel10k.zsh-theme" depth="1" romkatv/powerlevel10k;

source "$HOME/.dotconfig/prompt-segment/init.zsh";

zinit lucid light-mode for pick="/dev/null" load='[[ true ]]' atload="prompt_my_midway_status_worker" "$HOME/.dotconfig/prompt-segment";

if [[ "$OSTYPE" == darwin* ]]; then
    zinit lucid light-mode for pick="/dev/null" load='[[ true ]]' atload="prompt_my_nds_status_worker" "$HOME/.dotconfig/prompt-segment";
else
    zinit lucid light-mode for pick="/dev/null" load='[[ true ]]' atload='prompt_my_bbserver_status_worker' "$HOME/.dotconfig/prompt-segment";
fi;