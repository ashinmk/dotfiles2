#!/bin/bash
currentDir=$(pwd);
ln -f -s "${currentDir}/zshrc" ~/.zshrc
ln -f -s "${currentDir}/zshprofile" ~/.zshprofile

for initFile in $(find . -name init.sh); do
    source "$initFile";
done;