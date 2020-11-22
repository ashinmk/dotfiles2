fzf-brazil-add-package() {
    local currentWS="$BRAZIL_WS_DIR/"$(pwd | sed "s:$BRAZIL_WS_DIR/::g" | cut -d '/' -f 1);
    local versionSet=$(cat $currentWS/packageInfo | rg versionSet | cut -d '"' -f 2);
    local out=$(cat "$currentWS/release-info/versionSets/$versionSet" | rg '"packages"=\{.+' -o | cut -d '{' -f 2 | cut -d '}' -f 1 \
    | sed 's/;/\n/g' | tr -d '"' \
    | fzf --expect='alt-v,alt-m'
    );
    local selectedBranch altCommand;
    altCommand=$(head -1 <<<"$out");
    selectedPackageRef=$(head -2 <<<"$out" | tail -1);
    if [[ ! -z "$selectedPackageRef" ]]; then
        local packageName=$(echo $selectedPackageRef | cut -d '=' -f 1 | rev | cut -d '-' -f2- | rev);
        if [[ "$altCommand" = "alt-v" ]]; then
            local majorVersion=$(echo $selectedPackageRef | cut -d '=' -f 1 | rev | cut -d '-' -f1 | rev);
            BUFFER="brazil ws use -p $packageName -mv $majorVersion";
        elif [[ "$altCommand" = "alt-m" ]]; then
            local minorVersion=$(echo $selectedPackageRef | cut -d '=' -f 2);
            BUFFER="brazil ws use -p $packageName -v $minorVersion";
        else
            BUFFER="brazil ws use -p $packageName";
        fi;
        zle accept-line;
    fi
}

zle -N fzf-brazil-add-package;
bindkey '\eba' fzf-brazil-add-package;

fzf-brazil-remove-package() {
    local currentWS="$BRAZIL_WS_DIR/"$(pwd | sed "s:$BRAZIL_WS_DIR/::g" | cut -d '/' -f 1);
    local packageName=$(cat $currentWS/packageInfo | tr -d '\n' | rg 'packages = .+' -o | cut -d '{' -f 2 | cut -d '}' -f 1 | tr -d ' ' | sed 's/=.;*/\n/g' \
    | rev | cut -d '-' -f 2- | rev | fzf);
    if [[ ! -z "$packageName" ]]; then
        BUFFER="brazil ws remove -p $packageName";
        zle accept-line;
    fi;
}

zle -N fzf-brazil-remove-package;
bindkey '\ebr' fzf-brazil-remove-package;

zle-brazil-sync() {
    BUFFER="brazil ws sync --md";
    zle accept-line;
}

zle -N zle-brazil-sync;
bindkey '\ebs' zle-brazil-sync;