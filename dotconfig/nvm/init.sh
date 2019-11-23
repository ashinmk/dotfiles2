nvm() {
    if [[ -d '/usr/local/opt/nvm' ]]; then
        export NVM_DIR="$HOME/.nvm"

        source "${NVM_DIR}/nvm.sh"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm

        if [[ -e ~/.nvm/alias/default ]]; then
            PATH="${PATH}:${HOME}.nvm/versions/node/$(cat ~/.nvm/alias/default)/bin"
        fi
        # invoke the real nvm function now
        nvm "$@"
    else
        echo "nvm is not installed" >&2
        return 1
    fi
}
