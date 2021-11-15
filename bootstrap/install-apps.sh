#!/bin/zsh

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";

# Install zinit
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/master/doc/install.sh)";

# Install Apps from Brew
brew install \
zsh git awk coreutils findutils gnu-sed wget \
bat exa fd fzf git-delta ripgrep jq miller micro dos2unix sd \
bandwhich dog ifstat hyperfine procs \
ddcctl \
graphviz pandoc tesseract;

# Install Essential Applications
brew install --cask 1password alfred arq contexts google-drive hammerspoon iina istat-menus iterm2 kap karabiner-elements postman rescuetime slack spotify vanilla visual-studio-code;

mas install 1091189122; # Bear
mas install 1470584107; # Dato
mas install 1485052491; # Dropzone
mas install 405399194; # Kindle
mas install 973213640; # MSG Viewer For Outlook
mas install 568494494; # Pocket
mas install 425424353; # The Unarchiver
mas install 585829637; # Todoist
mas install 957734279; # Toggl


# Nerd Fonts for terminal rendering
brew tap homebrew/cask-fonts && brew install --cask font-fira-code-nerd-font;

echo "Installing Volta";
curl https://get.volta.sh | bash

echo "Installing Node";
volta install node;

npm install -g catj;

echo "Installing SDKMan";
curl -s "https://get.sdkman.io" | bash;

echo "Installing JDK15";
source "$HOME/.sdkman/bin/sdkman-init.sh";
sdk install java 15.0.1-amzn;

# Amazon Install
if type "mwinit" > /dev/null; then
    repoDir="${0:A:h:h}";
    source "$repoDir/bootstrap/install-amazon-apps.sh";
else
    echo "Midway not installed";
fi;
