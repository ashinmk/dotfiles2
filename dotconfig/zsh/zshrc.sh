# Uncomment to benchmark load-time
#zmodload zsh/zprof

export PATH="${HOME}/Scripts/bin:${HOME}/.toolbox/bin:$PATH"

source "$HOME/.dotconfig/early-env-setup/zsh-opts.sh";

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

source "$HOME/.dotconfig/early-env-setup/brew-env-setup.sh";

export BRAZIL_WS_DIR="$HOME/ws";

for initFile in $HOME/.dotconfig/*/init.sh; do
    source "$initFile"
done

for initFile in $HOME/.amazon.ext.dotconfig/*/init.sh; do
    source "$initFile"
done

for aliasFile in $HOME/.dotconfig/*/aliases.sh; do
    source "$aliasFile"
done

zinit light-mode for pick="powerlevel10k.zsh-theme" src="$HOME/.dotconfig/p10k/p10k.zsh" depth="1" romkatv/powerlevel10k;

zinit wait lucid light-mode for id-as="lazy-init" pick="lazy-init.sh" "${HOME}/.dotconfig";

# Uncomment to benchmark load-time
#zprof
