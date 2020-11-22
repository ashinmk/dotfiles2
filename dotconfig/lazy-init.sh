zinit wait lucid light-mode for \
    atinit='zicompinit; zicdreplay' zdharma/fast-syntax-highlighting \
    atload='_zsh_autosuggest_start' zsh-users/zsh-autosuggestions \
    blockf atpull='zinit creinstall -q .' zsh-users/zsh-completions

zinit wait lucid for id-as="iterm2-shell-integration" pick=".iterm2_shell_integration.zsh" "${HOME}";

for lazyInitFile in $HOME/.dotconfig/*/init.lazy.sh; do
    local fileDir=${${lazyInitFile%/*}##*/};
    zinit wait lucid light-mode for id-as="fileDir" nocd pick="$lazyInitFile" "${HOME}/.dotconfig/$fileDir";
done