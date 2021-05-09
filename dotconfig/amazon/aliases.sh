function nds() {
    (nohup ninja-dev-sync > /tmp/ninja-dev-sync.out 2>&1 &) 2>&1
}

function auth() {
    if [[ "$HOST" =~ "^dev-dsk.*" ]]; then
        kinit -f -l 86400 && touch "/tmp/.recently-authorized";
    else
        kinit.exp $USER && mwinit.exp $USER && (ssh-add > /dev/null) && touch "/tmp/.recently-authorized";
        (rsync -aquv ~/.midway $USER.aka.corp.amazon.com:/home/$USER/ &) > /dev/null;
        (print_password | (ssh -q $USER.aka.corp.amazon.com "kinit -f -l 86400  && touch \"/tmp/.recently-authorized\"" > /dev/null) &) > /dev/null;
    fi;
}

function print_password() {
    security find-generic-password -l "NoMAD" -g 2>&1 | grep password | awk '{print $2}' | sed 's/"//g';
}
