PATH="${PATH}:${HOME}/.nvm/versions/node/v12.8.0/bin"

nvm() {
    export NVM_DIR="$HOME/.nvm"
    source "${NVM_DIR}/nvm.sh"

    nvm "$@" # invoke the real nvm function now
}