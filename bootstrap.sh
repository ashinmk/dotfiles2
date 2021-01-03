#!/bin/bash
currentDir=$(pwd);

# Since we are symlinking this, remove if already exists.
rm -rf ~/.dotconfig;
ln -f -s "${currentDir}/dotconfig" ~/.dotconfig;

# Create amazon.ext.dotconfig if not existing. Do not delete.
mkdir -p ~/.amazon.ext.dotconfig/sample;
touch ~/.amazon.ext.dotconfig/sample/init.sh

for bootstrapFile in $(find -L dotconfig -name bootstrap.sh); do
    source "$bootstrapFile";
done;
