fzf-git-change-branch() {
    local out;
    out=$(git br | tr -d '*' | tr -d '[:blank:]' | fzf --preview 'git hmm --color {}'  --preview-window right:70% --expect=alt-d);
    local selectedBranch altCommand;
    altCommand=$(head -1 <<<"$out");
    selectedBranch=$(head -2 <<<"$out" | tail -1);
    if [[ ! -z "$selectedBranch" ]]; then
        if [[ "$altCommand" = "alt-d" ]]; then
            BUFFER="git br -D \"$selectedBranch\""
        else
            BUFFER="git co \"$selectedBranch\""
        fi;
        zle accept-line;
    fi
    zle reset-prompt;
}

zle -N fzf-git-change-branch;
bindkey '\egb' fzf-git-change-branch;

fzf-git-change-branch-remote() {
    local selectedBranch;
    selectedBranch=$(git br -r | tr -d '*' | tr -d '[:blank:]' | fzf --preview 'git hmm --color {}'  --preview-window right:70%);
    [[ -z "$selectedBranch" ]] || git co "$selectedBranch";
    zle reset-prompt;
}

zle -N fzf-git-change-branch-remote;
bindkey '\egB' fzf-git-change-branch-remote;

show-git-status() {
    git status;
    zle reset-prompt;
}

zle -N show-git-status;
bindkey '\egs' show-git-status;

fzf-git-rebase-interactive() {
    targetCommit=$(git hmm --color | fzf --ansi | cut -d '[' -f 2 | cut -d ']' -f 1);
    [[ -z "$targetCommit" ]] || git rebase -i "$targetCommit~1";
    zle reset-prompt;
}

zle -N fzf-git-rebase-interactive;
bindkey '\egr' fzf-git-rebase-interactive;

fzf-git-diff() {
    local selectedFile;
    selectedFile=$(git diff --name-only | fzf --preview 'git diff {}');
    [[ -z "$selectedFile" ]] || git diff "$selectedFile";
    zle reset-prompt;
}

zle -N fzf-git-diff;
bindkey '\egd' fzf-git-diff;