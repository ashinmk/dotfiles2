ln -f -s "${REPO_DIR}/dotconfig/zsh/zshenv.sh" $HOME/.zshenv
ln -f -s "${REPO_DIR}/dotconfig/zsh/zprofile.sh" $HOME/.zprofile
ln -f -s "${REPO_DIR}/dotconfig/zsh/zshrc.sh" $HOME/.zshrc

# Avoid unnecessary welcome message when starting up"
touch "$HOME/.hushlogin";
