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
        zle autosuggest-clear;
        zle accept-line;
    fi
}

zle -N fzf-brazil-add-package;
bindkey '\eba' fzf-brazil-add-package;

fzf-brazil-build() {
    if [[ ! -f "build.xml" ]]; then
        echo "No build.xml found";
    else
        local target=$(cat build.xml | rg 'target.+name="[^"]+"' -o | rg 'name=".+' -o | cut -d '"' -f 2 | fzf);
        if [[ ! -z "$target" ]]; then
            BUFFER="bb $target";
            zle autosuggest-clear;
            zle accept-line;
        fi;
    fi;
}

zle -N fzf-brazil-build;
bindkey '\ebb' fzf-brazil-build;

fzf-brazil-build-single-test() {
    if [[ ! -f "build.xml" ]]; then
        echo "No build.xml found";
    else
        local testClass=$(fd '.+java' tst | sed 's-^tst/--g' | sed 's-/-.-g' | sed 's/.java//g' | fzf);
        if [[ ! -z "$testClass" ]]; then
            BUFFER="bb single-test -DtestClass=$testClass";
            zle autosuggest-clear;
            zle accept-line;
        fi;
    fi;
}

zle -N fzf-brazil-build-single-test;
bindkey '\ebt' fzf-brazil-build-single-test;

fzf-brazil-remove-package() {
    local currentWS="$BRAZIL_WS_DIR/"$(pwd | sed "s:$BRAZIL_WS_DIR/::g" | cut -d '/' -f 1);
    local packageName=$(cat $currentWS/packageInfo | tr -d '\n' | rg 'packages = .+' -o | cut -d '{' -f 2 | cut -d '}' -f 1 | tr -d ' ' | sed 's/=.;*/\n/g' \
    | rev | cut -d '-' -f 2- | rev | fzf);
    if [[ ! -z "$packageName" ]]; then
        BUFFER="brazil ws remove -p $packageName";
        zle autosuggest-clear;
        zle accept-line;
    fi;
}

zle -N fzf-brazil-remove-package;
bindkey '\ebr' fzf-brazil-remove-package;

zle-brazil-show() {
    BUFFER="brazil ws show";
    zle accept-line;
}

zle -N zle-brazil-show;
bindkey '\ebs' zle-brazil-show;

zle-brazil-sync() {
    BUFFER="brazil ws sync --md";
    zle accept-line;
}

zle -N zle-brazil-sync;
bindkey '\ebS' zle-brazil-sync;

zle-fzf-cr() {
    local currentWS="$BRAZIL_WS_DIR/"$(pwd | sed "s:$BRAZIL_WS_DIR/::g" | cut -d '/' -f 1);
    local out=$(ls $currentWS/src | fzf --multi --expect="alt-enter");
    local cmd=$(echo "$out" | head -1);
    local packages=$(echo "$out" | tail -n +2);
    if [[ -z "$packages" ]]; then
        return 0;
    fi;
    local packageRef=$(echo $packages | sed -r 's.$.[HEAD~1].g' | paste -s -d ',');
    local numPackages=$(echo $packages | wc -l);
    if [[ "$numPackages" -eq 1 ]]; then
        BUFFER='cr --include "'$packageRef'"';
    elif [[ -z "$cmd" ]]; then
        BUFFER='cr --include "'$packageRef'" --new-review';
    else
        BUFFER='cr --include "'$packageRef'"';
    fi;
}

zle -N zle-fzf-cr;
bindkey '\ebc' zle-fzf-cr;
