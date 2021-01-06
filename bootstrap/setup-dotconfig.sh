#!/bin/zsh

repoDir=${0:A:h:h}; # Current file's ($0) absolute path's (:A) dir's parent dir. (:h)

rm -rf $HOME/.dotconfig; # Since we are symlinking this dir, remove if already exists.
ln -f -s "${repoDir}/dotconfig" $HOME/.dotconfig;

mkdir -p $HOME/.amazon.ext.dotconfig/sample; # Create amazon.ext.dotconfig if it doesn't already exist.
touch $HOME/.amazon.ext.dotconfig/sample/init.sh # Add placeholder.

for bootstrapFile in ${repoDir}/dotconfig/*/bootstrap.sh; do
    source "$bootstrapFile";
done;
