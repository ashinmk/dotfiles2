#!/bin/bash
currentDir=$(pwd);
touch "$HOME/.hushlogin"

rm -rf ~/.dotconfig;
ln -f -s "${currentDir}/dotconfig" ~/.dotconfig;
rm -rf ~/.amazon.ext.dotconfig
mkdir -p ~/.amazon.ext.dotconfig/sample;
touch ~/.amazon.ext.dotconfig/sample/init.sh

for bootstrapFile in $(find -L dotconfig -name bootstrap.sh); do
    source "$bootstrapFile";
done;
