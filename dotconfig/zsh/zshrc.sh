# Uncomment to benchmark load-time
#zmodload zsh/zprof

export PATH="${HOME}/Scripts/bin:${HOME}/.toolbox/bin:$PATH"

for earlyInitFile in $HOME/.dotconfig/early-env-setup/*.sh; do
    source "$earlyInitFile";
done

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

for initFile in $HOME/.dotconfig/*/init.eager.sh; do
    source "$initFile"
done

for initFile in $HOME/.amazon.ext.dotconfig/*/init.sh; do
    source "$initFile"
done

for aliasFile in $HOME/.dotconfig/*/aliases.sh; do
    source "$aliasFile"
done

zinit light-mode for pick="powerlevel10k.zsh-theme" src="$HOME/.dotconfig/p10k/p10k.zsh" depth="1" romkatv/powerlevel10k;

zinit wait lucid light-mode for id-as="lazy-init" pick="lazy-init-all.sh" "${HOME}/.dotconfig/zsh";

# Uncomment to benchmark load-time
#zprof
