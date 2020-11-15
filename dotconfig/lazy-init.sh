for lazyInitFile in $HOME/.dotconfig/*/init.lazy.sh; do
    source "$lazyInitFile";
done