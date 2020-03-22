#!/bin/bash
currentDir=$(pwd);
ln -f -s "${currentDir}/zshenv.sh" ~/.zshenv
ln -f -s "${currentDir}/zprofile.sh" ~/.zprofile
ln -f -s "${currentDir}/zshrc.sh" ~/.zshrc

ln -f -s "${currentDir}/homebrew_init.sh" ~/.homebrew_init
ln -f -s "${currentDir}/zpreztorc.sh" ~/.zpreztorc

rm -rf ~/.dotconfig;
ln -f -s "${currentDir}/dotconfig" ~/.dotconfig;
rm -rf ~/.amazon.ext.dotconfig
ln -f -s "${currentDir}/amazon.ext.dotconfig" ~/.amazon.ext.dotconfig;

for bootstrapFile in $(find -L dotconfig -name bootstrap.sh); do
    source "$bootstrapFile";
done;