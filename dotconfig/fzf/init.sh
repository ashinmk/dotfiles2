zinit depth="1" src="shell/key-bindings.zsh" for junegunn/fzf;

bindkey -r '^T';    # Remove default FZF File Select
[ -f "$DOTCONFIG_DIR/fzf/catj-fzf.zsh" ] && source "$DOTCONFIG_DIR/fzf/catj-fzf.zsh";

fzf-file-select() {
    local out file key
    out=$(fd -t f | fzf --bind 'alt-e:execute-silent('$EDITOR' {})+abort,alt-v:execute-silent(code {})+abort');
    if [[ ! -z "$out" ]]; then
        LBUFFER="${LBUFFER}$out";
    fi;
}
zle -N fzf-file-select;
bindkey '^t' fzf-file-select;

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
    zle push-line # Clear buffer. Auto-restored on next prompt.
    BUFFER="cd ${(q)dir}"
    zle accept-line
    local ret=$?
    unset dir # ensure this doesn't end up appearing in prompt expansion
    zle reset-prompt
    return $ret
}

# ALT-w - cd into packages in current WS
fzf-cd-ws-pkg-widget() {
    local currentWS="$BRAZIL_WS_DIR/"$(pwd | sed "s:$BRAZIL_WS_DIR/::g" | cut -d '/' -f 1);
    fzf-cd "fd -d 1 -t d . $currentWS/src"
    return $?
}
zle -N fzf-cd-ws-pkg-widget
bindkey '\eW' fzf-cd-ws-pkg-widget

# ALT-W - cd into packages across WSes
fzf-cd-ws-widget() {
    fzf-cd "fd -d 1 -t d . $BRAZIL_WS_DIR/*/src"
    return $?
}
zle -N fzf-cd-ws-widget
bindkey '\ew' fzf-cd-ws-widget

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
