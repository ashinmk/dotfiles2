#!/bin/bash
currentDir=$(pwd);
touch "$HOME/.hushlogin"

rm -rf ~/.dotconfig;
ln -f -s "${currentDir}/dotconfig" ~/.dotconfig;
rm -rf ~/.amazon.ext.dotconfig
ln -f -s "${currentDir}/amazon.ext.dotconfig" ~/.amazon.ext.dotconfig;

for bootstrapFile in $(find -L dotconfig -name bootstrap.sh); do
    source "$bootstrapFile";
done;
