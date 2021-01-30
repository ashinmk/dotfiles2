#!/bin/zsh

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";

# Install zinit
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)";

# Install Apps from Brew
brew install \
zsh git awk coreutils findutils gnu-sed wget \
bat exa fd fzf git-delta ripgrep jq miller micro dos2unix sd \
bandwhich dog ifstat hyperfine procs \
graphviz pandoc tesseract;

echo "Installing NVM";

NVM_VERSION_TO_INSTALL="v0.37.2";
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION_TO_INSTALL/install.sh" | bash

## Setup NVM for use right now
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")";
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh";

NODE_VERSION_TO_INSTALL="v12.19.0";
nvm install "$NODE_VERSION_TO_INSTALL";
npm install -g catj;

# Amazon Install
if type "mwinit" > /dev/null; then
    repoDir="${0:A:h:h}";
    source "$repoDir/bootstrap/install-amazon-apps.sh";
else
    echo "Midway not installed";
fi;
