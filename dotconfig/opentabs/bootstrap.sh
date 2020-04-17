rm -f ~/.opentabs
ln -f -s "$(pwd)/dotconfig/opentabs" ~/.opentabs

export PATH=$PATH:~/.opentabs/bin