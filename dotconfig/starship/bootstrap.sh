rm -f ~/.starship-init.sh ~/.config/starship.toml ~/.config/starship.transient.toml

ln -f -s "$(pwd)/dotconfig/starship/starship-init.sh" ~/.starship-init.sh
ln -f -s "$(pwd)/dotconfig/starship/starship.toml" ~/.config/starship.toml
ln -f -s "$(pwd)/dotconfig/starship/starship.transient.toml" ~/.config/starship.transient.toml