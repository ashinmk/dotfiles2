# Uncomment to benchmark load-time
#SHOULD_PROFILE_ZSH_STARTUP="true";
if [[ ! -z "$SHOULD_PROFILE_ZSH_STARTUP" ]]; then
    zmodload zsh/zprof;
fi;

export PATH="${HOME}/Scripts/bin:${HOME}/.toolbox/bin:$PATH"

for earlyInitFile in $HOME/.dotconfig/early-env-setup/*.sh; do
    source "$earlyInitFile";
done

if [[ "$OSTYPE" == "darwin"* ]]; then
    source "${HOME}/.local/share/zinit/zinit.git/zinit.zsh";
else
    source "$HOME/.zinit/bin/zinit.zsh";
fi;
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

for initFile in $DOTCONFIG_DIR/*/init.eager.sh; do
    source "$initFile"
done

for initFile in $HOME/.amazon.ext.dotconfig/*/init.sh; do
    source "$initFile"
done

for aliasFile in $DOTCONFIG_DIR/*/aliases.sh; do
    source "$aliasFile"
done

zinit light-mode for pick="powerlevel10k.zsh-theme" src="$DOTCONFIG_DIR/p10k/p10k.zsh" depth="1" romkatv/powerlevel10k;

zinit wait lucid light-mode for id-as="lazy-init" pick="lazy-init-all.sh" "$DOTCONFIG_DIR/zsh";

export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"

if [[ ! -z "$SHOULD_PROFILE_ZSH_STARTUP" ]]; then
    zprof;
fi;
