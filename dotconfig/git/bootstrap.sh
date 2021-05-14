ln -f -s "$REPO_DIR/dotconfig/git/gitignore" ~/.gitignore
ln -f -s "$REPO_DIR/dotconfig/git/gitconfig" ~/.gitconfig
if [[ ! -f "$REPO_DIR/dotconfig/git/gitconfig.$USER" ]]; then
    touch "$REPO_DIR/dotconfig/git/gitconfig.$USER";
fi;
mkdir -p "$HOME/.config/git";
ln -f -s "$REPO_DIR/dotconfig/git/gitconfig.$USER" "$HOME/.config/git/.gitconfig.user"
