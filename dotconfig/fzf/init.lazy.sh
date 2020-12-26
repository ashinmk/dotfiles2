bindkey -r '^T';    # Remove default FZF File Select
[ -f "${current_dir}/catj-fzf.zsh" ] && source "${current_dir}/catj-fzf.zsh"

fzf-file-select() {
    local out file key
    out=$(fd -t f | fzf --bind 'alt-e:execute-silent('$EDITOR' {})+abort,alt-v:execute-silent(code {})+abort');
    if [[ ! -z "$out" ]]; then
        BUFFER="${LBUFFER}$out${RBUFFER}";
    fi;
}
zle -N fzf-file-select;
bindkey '\et' fzf-file-select;

export FZF_DEFAULT_COMMAND="fd"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

fzf-select-lazy() {
    local input_query="$1"
    local expected_hotkeys="$2"
    local input_data=$(eval $1)
    fzf-select "${input_data}" "${expected_hotkeys}"
    return $?
}

fzf-select() {
    local input_data="$1"
    local expected_hotkeys="$2"
    if [[ -z "${expected_hotkeys}" ]]; then
        local expected_hotkey_params=""
    else
        local expected_hotkey_params="--expect=\"${expected_hotkeys}\""
    fi
    local query='echo "${input_data}" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" fzf '${expected_hotkey_params}
    local data="$(eval ${query})"
    local return_value=$?
    fzf_selected_text=$(head -2 <<<"$data" | tail -1)
    fzf_selected_hotkey=$(head -1 <<<"$data")
    return ${return_value}
}

fzf-cd() {
    fzf-select-lazy "$1" "$2"
    local dir=$fzf_selected_text
    if [[ -z "$dir" ]]; then
        zle redisplay
        return 0
    fi
    cd "$dir"
    local return_value=$?
    zle fzf-redraw-prompt
    return $return_value
}

# ALT-W - cd into $HOME/ws
fzf-cd-ws-widget() {
    fzf-cd "fd -d 1 -t d . $HOME/ws/*/src"
    return $?
}
zle -N fzf-cd-ws-widget
bindkey '\ew' fzf-cd-ws-widget

# ALT-W - cd into Candybar
fzf-cd-candybar-widget() {
    fzf-cd "fd -t d -d 1 . $HOME/Candybar"
    return $?
}
zle -N fzf-cd-candybar-widget
bindkey '\eW' fzf-cd-candybar-widget

# ALT-c - cd inside current dir
fzf-cd-pwd-widget() {
    fzf-cd "fd -t d ."
    return $?
}
zle -N fzf-cd-pwd-widget
bindkey '\ec' fzf-cd-pwd-widget

# ALT-C - cd inside home
fzf-cd-home-widget() {
    fzf-cd "fd -t d . -p \"$HOME\""
    return $?
}
zle -N fzf-cd-home-widget
bindkey '\eC' fzf-cd-home-widget


fzf-kill-process-widget() {
    local selectedApp;
    if [ "$UID" != "0" ]; then
        selectedApp=$(ps -f -u $UID | sed 1d | awk '{print $2 " " substr($0, index($0, $8))}' | fzf)
    else
        selectedApp=$(ps -ef | sed 1d | awk '{print $2 " " substr($0, index($0, $8))}' | fzf)
    fi;
    if [[ "x$selectedApp" != "x" ]]; then
        local pid=$(echo $selectedApp | awk '{print $1}');
        local process=$(echo $selectedApp | awk '{print $2}');
        echo $pid | xargs kill;
        echo "Killed Process: ${process} with PID: ${pid}"
    fi;
}

zle -N fzf-kill-process-widget;
bindkey '\ek' fzf-kill-process-widget;