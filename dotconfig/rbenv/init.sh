export PATH="$HOME/.rbenv/shims:${PATH}"
rbenv() {
    unset -f rbenv;
    if which rbenv >/dev/null; then eval "$(rbenv init -)"; fi
    rbenv "$@";
}

