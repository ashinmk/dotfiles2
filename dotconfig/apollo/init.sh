bindkey -r '\ea';   # Unbind default

fzf-apollo-activate() {
    local apolloEnv=$(ls /apollo/env | rg -v 'CONSUMES' | awk '{print $1}' | fzf);
    if [[ ! -z "$apolloEnv" ]]; then
        BUFFER="sudo /apollo/bin/runCommand -a Activate -e $apolloEnv";
        zle accept-line;
    fi;
}
zle -N fzf-apollo-activate
bindkey '\eaa' fzf-apollo-activate

fzf-apollo-deactivate() {
    local apolloEnv=$(ps -eaf | rg '/apollo/env' | rg -v 'CONSUMES|KeyMasterDaemonWorkspaceSupport|AAAWorkspaceSupport' | rg '/apollo/env/[a-zA-Z]+/' -o | cut -d '/' -f 4 | sort | uniq | fzf);
    if [[ ! -z "$apolloEnv" ]]; then
        BUFFER="sudo /apollo/bin/runCommand -a Deactivate -e $apolloEnv";
        zle accept-line;
    fi;
}
zle -N fzf-apollo-deactivate
bindkey '\ead' fzf-apollo-deactivate