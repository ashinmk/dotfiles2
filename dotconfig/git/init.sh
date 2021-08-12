is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-git-change-branch() {
    is_in_git_repo || return
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
        zle autosuggest-clear;
        zle accept-line;
    fi
}

zle -N fzf-git-change-branch;
bindkey '\egb' fzf-git-change-branch;

fzf-git-change-branch-remote() {
    is_in_git_repo || return
    local selectedBranch;
    selectedBranch=$(git br -r | tr -d '*' | tr -d '[:blank:]' | fzf --preview 'git hmm --color {}'  --preview-window right:70%);
    [[ -z "$selectedBranch" ]] || BUFFER="git co \"${selectedBranch}\"" && zle autosuggest-clear && zle accept-line;
    zle reset-prompt;
}

zle -N fzf-git-change-branch-remote;
bindkey '\egB' fzf-git-change-branch-remote;

zle-show-git-status() {
    is_in_git_repo || return
    BUFFER="git status";
    zle accept-line;
}

zle -N zle-show-git-status;
bindkey '\egs' zle-show-git-status;

fzf-git-rebase-interactive() {
    is_in_git_repo || return
    targetCommit=$(git hmm --color | fzf --ansi | cut -d '[' -f 2 | cut -d ']' -f 1);
    [[ -z "$targetCommit" ]] || BUFFER="git rebase -i \"${targetCommit}~1\"";
    zle autosuggest-clear;
    zle accept-line;
}

zle -N fzf-git-rebase-interactive;
bindkey '\egr' fzf-git-rebase-interactive;

fzf-git-diff() {
    is_in_git_repo || return
    local selectedFile;
    local gitRootDir=$(git rev-parse --show-toplevel);
    selectedFile=$(git diff --name-only | fzf --preview-window top:80%,border-horizontal --preview 'git diff --color '${gitRootDir}'/{}');
    [[ -z "$selectedFile" ]] || BUFFER="git diff \"${gitRootDir}/${selectedFile}\"";
    zle autosuggest-clear && zle accept-line;
}

zle -N fzf-git-diff;
bindkey '\egd' fzf-git-diff;


zle-git-hmm() {
    is_in_git_repo || return
    BUFFER="git hmm";
    zle accept-line;
}

zle -N zle-git-hmm;
bindkey '\egh' zle-git-hmm;

fzf-git-add() {
    is_in_git_repo || return
    local gitRootDir=$(git rev-parse --show-toplevel);
    local modifiedFiles=$(git diff --name-only);
    local untrackedPaths=$(git ls-files $gitRootDir --exclude-standard --others --full-name);
    local selectedFiles=$(echo "${modifiedFiles}\n${untrackedPaths}" | rg -N . | fzf -m --reverse --preview 'git diff --color '${gitRootDir}'/{}');
    if [[ ! -z "$selectedFiles" ]]; then
        selectedFiles=$(echo $selectedFiles | sd '^(.+)' "$gitRootDir/\$1" | sd '\n' ' ');
        BUFFER=" git add ${selectedFiles}";
        zle autosuggest-clear && zle accept-line;
    fi;
}

zle -N fzf-git-add;
bindkey '\ega' fzf-git-add;

fzf-git-unstage() {
    is_in_git_repo || return
    local gitRootDir=$(git rev-parse --show-toplevel);
    local selectedFiles=$(git diff --cached --name-only | fzf -m --reverse --preview 'git diff --color '${gitRootDir}'/{}');
    if [[ ! -z "$selectedFiles" ]]; then
        selectedFiles=$(echo $selectedFiles | sd '^(.+)' "$gitRootDir/\$1" | sd '\n' ' ');
        BUFFER=" git restore --staged ${selectedFiles}";
        zle autosuggest-clear && zle accept-line;
    fi;
}

zle -N fzf-git-unstage;
bindkey '\egA' fzf-git-unstage;

zle-git-pull() {
    is_in_git_repo || return
    BUFFER="git pull";
    zle accept-line;
}

zle -N zle-git-pull;
bindkey '\egp' zle-git-pull;

zle-git-clean() {
    is_in_git_repo || return
    BUFFER="git clean -df";
    zle accept-line;
}

zle -N zle-git-clean;
bindkey '\egCC' zle-git-clean;  ## Make it harder for typos.

zle-git-commit() {
    is_in_git_repo || return;
    BUFFER="git commit";
    zle autosuggest-clear && zle accept-line;
}

zle -N zle-git-commit;
bindkey '\egc' zle-git-commit;

zle-git-commit-amend() {
    is_in_git_repo || return;
    BUFFER="git commit --amend";
    zle autosuggest-clear && zle accept-line;
}

zle -N zle-git-commit-amend;
bindkey '\egm' zle-git-commit-amend;
