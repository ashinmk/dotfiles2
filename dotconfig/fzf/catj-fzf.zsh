___FZF_CATJ_FILTER="catj | sed 's/\x1b\[[0-9;]*m//g'" #remove colour-codes as well

fzf-catj-pbp-widget() {
    local query="pbp | ${___FZF_CATJ_FILTER}"
    local catj_json="$(eval $query)"
    fzf-select "${catj_json}" 'alt-enter'
    if [[ "${fzf_selected_hotkey}" == "alt-enter" ]]; then

        local selected_data=$(echo "$fzf_selected_text" | cut -d '=' -f 2 | tr -d ' ')
    else
        # Select JSON Key
        local selected_data=$(echo "$fzf_selected_text" | cut -d '=' -f 1 | tr -d ' ')
    fi

    # To keep input-pointer in-place instead of end-of-line, we will do zle EOL after setting buffer to new lbuffer.
    # Follow-up by adding rbuffer.
    new_lbuffer="${LBUFFER}${selected_data}"
    new_rbuffer="${RBUFFER}"
    BUFFER="${new_lbuffer}"
    zle end-of-line
    BUFFER="${new_lbuffer}${new_rbuffer}"
    zle redisplay
    return $?
}
zle -N fzf-catj-pbp-widget
bindkey '\ep' fzf-catj-pbp-widget

fzf-catj-jq-widget() {
    local query="pbp | ${___FZF_CATJ_FILTER}"
    local catj_json="$(eval $query)"
    ___fzf-catj-jq-recursive-select "${catj_json}" ""
    BUFFER="$BUFFER | jq '{${catj_jq_selected_data}}'"
    zle redisplay
    zle end-of-line
    unset catj_jq_selected_data
}
zle -N fzf-catj-jq-widget
bindkey '\ej' fzf-catj-jq-widget

# Recursive json path selection
___fzf-catj-jq-recursive-select() {
    local input_data="$1"
    local ongoing_query="$2"
    fzf-select "${input_data}" 'alt-enter'
    if [[ "${fzf_selected_hotkey}" == "alt-enter" ]]; then
        catj_jq_selected_data="${ongoing_query}"
        return $?
    elif [[ -z "${fzf_selected_text}" ]]; then
        catj_jq_selected_data="${ongoing_query}"
        return $?
    fi
    local json_path=$(echo "$fzf_selected_text" | cut -d '=' -f 1 | tr -d ' ')
    local key_name="$(echo ${json_path} | rev | cut -d '.' -f 1 | rev)"
    local data_to_add="\"${key_name}\": ${json_path}"
    if [[ "${ongoing_query}" == "" ]]; then
        ongoing_query="${data_to_add}"
    else
        ongoing_query="${ongoing_query}, ${data_to_add}"
    fi
    ___fzf-catj-jq-recursive-select "${input_data}" "${ongoing_query}"
}
