zinit wait lucid light-mode for \
    atinit='zicompinit; zicdreplay' zdharma-continuum/fast-syntax-highlighting \
    atload='_zsh_autosuggest_start' zsh-users/zsh-autosuggestions \
    blockf atpull='zinit creinstall -q .' zsh-users/zsh-completions

for lazyInitFile in $DOTCONFIG_DIR/*/init.sh; do
    local fileDir=${${lazyInitFile%/*}##*/};
    zinit wait lucid light-mode for id-as="fileDir" nocd pick="$lazyInitFile" "$DOTCONFIG_DIR/$fileDir";
done
