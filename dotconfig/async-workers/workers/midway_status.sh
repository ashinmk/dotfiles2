function is_midway_valid() {
    if [[ ! -f $HOME/.midway/cookie ]] || (( $(rg "^#HttpOnly_midway-auth.amazon.com" $HOME/.midway/cookie | awk '{print $5}') < $(date +%s) )); then
        return 1;
    else
        return 0;
    fi;
}

if is_midway_valid; then
    echo 'export G_MIDWAY_STATUS="AUTHORIZED"';
else
    echo 'export G_MIDWAY_STATUS="NOT_AUTHORIZED"';
fi;