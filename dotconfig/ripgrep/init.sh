function search_with_fzf_rg() {
    local INITIAL_QUERY=""
    local RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case"
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
    fzf --bind "change:reload:$RG_PREFIX {q} || true" \
        --ansi --disabled --query "$INITIAL_QUERY" \
        --height=50% --layout=reverse;
}

function zle_search_with_fzf_rg() {
    search_with_fzf_rg;
    echo "";    # Needed since we use instant-prompt that clears the immediate preceeding line;
}

zle -N zle_search_with_fzf_rg;
bindkey '\eF' zle_search_with_fzf_rg;
