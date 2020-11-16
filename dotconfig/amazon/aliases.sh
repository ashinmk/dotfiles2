function nds() {
    (nohup ninja-dev-sync > /tmp/ninja-dev-sync.out 2>&1 &) 2>&1
}

function auth() {
    if [[ "$HOST" =~ "^dev-dsk.*" ]]; then
        kinit -f && mwinit -o && touch "/tmp/.recently-authorized";
    else
        kinit -f && mwinit --aea && ssh-add && touch "/tmp/.recently-authorized";
    fi;
}