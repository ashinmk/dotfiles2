function nds() {
    (nohup ninja-dev-sync > /tmp/ninja-dev-sync.out 2>&1 &) 2>&1
}

function auth() {
    if [[ "$HOST" =~ "^dev-dsk.*" ]]; then
        kinit -f -l 86400 && touch "/tmp/.recently-authorized";
    else
        kinit.exp gauthamw && mwinit.exp gauthamw && (ssh-add > /dev/null) && touch "/tmp/.recently-authorized";
        (rsync -aquv ~/.midway gauthamw.aka.corp.amazon.com:/home/gauthamw/ &) > /dev/null;
        (rsync -aquv /tmp/.recently-authorized gauthamw.aka.corp.amazon.com:/home/gauthamw/ &) > /dev/null;
        (print_password | (ssh -q gauthamw.aka.corp.amazon.com "kinit -f -l 86400  && touch \"/tmp/.recently-authorized\"" > /dev/null) &) > /dev/null;
    fi;
}

function print_password() {
    security find-generic-password -l "NoMAD" -g 2>&1 | grep password | awk '{print $2}' | sed 's/"//g';
}
