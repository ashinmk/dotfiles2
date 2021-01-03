ln -f -s "${PWD}/dotconfig/zsh/zshenv.sh" $HOME/.zshenv
ln -f -s "${PWD}/dotconfig/zsh/zprofile.sh" $HOME/.zprofile
ln -f -s "${PWD}/dotconfig/zsh/zshrc.sh" $HOME/.zshrc

# Avoid unnecessary welcome message when starting up"
touch "$HOME/.hushlogin";
