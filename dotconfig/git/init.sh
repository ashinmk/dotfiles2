fzf-git-change-branch() {
    local selectedBranch;
    selectedBranch=$(git br | tr -d '*' | tr -d '[:blank:]' | fzf --preview 'git hmm --color {}'  --preview-window right:70%);
    [[ -z "$selectedBranch" ]] || git co "$selectedBranch";
    zle reset-prompt;
}

zle -N fzf-git-change-branch;
bindkey '\egb' fzf-git-change-branch;

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