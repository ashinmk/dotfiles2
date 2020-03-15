current_dir=${0:h}
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f "${current_dir}/catj-fzf.zsh" ] && source "${current_dir}/catj-fzf.zsh"

fo() {
    local out file key
    IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
    key=$(head -1 <<<"$out")
    file=$(head -2 <<<"$out" | tail -1)
    if [ -n "$file" ]; then
        [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
    fi
}

export FZF_DEFAULT_COMMAND="fd . $HOME"
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

# ALT-W - cd into /ws
fzf-cd-ws-widget() {
    fzf-cd "fd -d 1 -t d . /ws/*/src"
    return $?
}
zle -N fzf-cd-ws-widget
bindkey '\ew' fzf-cd-ws-widget

# ALT-D - cd inside current dir
fzf-cd-pwd-widget() {
    fzf-cd "fd -t d ."
    return $?
}
zle -N fzf-cd-pwd-widget
bindkey '\ed' fzf-cd-pwd-widget

# ALT-D - cd inside current dir
fzf-cd-home-widget() {
    fzf-cd "fd -t d . -p \"$HOME\""
    return $?
}
zle -N fzf-cd-home-widget
bindkey '\ec' fzf-cd-home-widget


fzf-kill-process-widget() {
    local selectedApp;
    if [ "$UID" != "0" ]; then
        selectedApp=$(ps -f -u $UID | sed 1d | awk '{print $2 " " $8}' | fzf)
    else
        selectedApp=$(ps -ef | sed 1d | awk '{print $2 " " $8}' | fzf)
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