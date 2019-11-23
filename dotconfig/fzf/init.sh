[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
export FZF_CD_COMMAND="fd -t d . $HOME"
export FZF_CD_WS_COMMAND="fd -d 1 -t d . /ws/*/src"
export FZF_CD_PWD_COMMAND="fd -t d ."

fzf-cd() {
    local dir="$(eval "$1" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS" $(__fzfcmd) +m)"
    if [[ -z "$dir" ]]; then
        zle redisplay
        return 0
    fi
    cd "$dir"
    local ret=$?
    zle fzf-redraw-prompt
    return $ret
}
# ALT-W - cd into /ws
fzf-cd-ws-widget() {
    fzf-cd "$FZF_CD_WS_COMMAND";
    return $?;
}
zle -N fzf-cd-ws-widget
bindkey '\ew' fzf-cd-ws-widget

# ALT-D - cd to current dir
fzf-cd-pwd-widget() {
    fzf-cd "$FZF_CD_PWD_COMMAND";
    return $?;
}
zle -N fzf-cd-pwd-widget
bindkey '\ed' fzf-cd-pwd-widget

