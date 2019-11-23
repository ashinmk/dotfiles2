#!/bin/bash
currentDir=$(pwd);
ln -f -s "${currentDir}/zshrc.sh" ~/.zshrc
ln -f -s "${currentDir}/zshprofile.sh" ~/.zshprofile

for initFile in $(find . -name init.sh); do
    source "$initFile";
done;