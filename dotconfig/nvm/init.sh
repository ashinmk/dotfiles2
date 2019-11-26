PATH="${PATH}:${HOME}/.nvm/versions/node/$(cat ~/.nvm/alias/default)/bin"

nvm() {
    export NVM_DIR="$HOME/.nvm"
    source "${NVM_DIR}/nvm.sh"

    nvm "$@" # invoke the real nvm function now
}