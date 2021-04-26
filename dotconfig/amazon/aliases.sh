function nds() {
    (nohup ninja-dev-sync > /tmp/ninja-dev-sync.out 2>&1 &) 2>&1
}

function auth() {
    if [[ "$HOST" =~ "^dev-dsk.*" ]]; then
        kinit -f -l 86400 && touch "/tmp/.recently-authorized";
    else
        kinit -f -l 86400 && mwinit --aea && ssh-add && touch "/tmp/.recently-authorized";
        rsync -aquv ~/.midway gauthamw.aka.corp.amazon.com:/home/gauthamw/ &;
        rsync -aquv /tmp/.recently-authorized gauthamw.aka.corp.amazon.com:/home/gauthamw/ &;
    fi;
}
