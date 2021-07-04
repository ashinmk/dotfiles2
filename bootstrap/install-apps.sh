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

echo "Installing Volta";
curl https://get.volta.sh | bash

echo "Installing Node";
volta install node;

npm install -g catj;

# Amazon Install
if type "mwinit" > /dev/null; then
    repoDir="${0:A:h:h}";
    source "$repoDir/bootstrap/install-amazon-apps.sh";
else
    echo "Midway not installed";
fi;
