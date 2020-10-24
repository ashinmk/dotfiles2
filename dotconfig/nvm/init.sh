my_last_known_node_version="v14.7.0";

node_alias_not_updated_recently=(~/.nvm/alias/default(Nm+1));
if [[ ! -z "$node_alias_not_updated_recently" ]]; then
    node_version_to_use="$my_last_known_node_version";
else
    node_version_in_alias=$(cat ~/.nvm/alias/default);
    if [[ $my_last_known_node_version = $node_version_in_alias ]]; then
        touch -d "48 hours ago" ~/.nvm/alias/default;
    else
        echo "NVM version out of sync; Needs update. New Version: $node_version_in_alias";
    fi
    node_version_to_use="$node_version_in_alias";
    unset node_version_in_alias;
fi;
unset node_alias_not_updated_recently;
unset my_last_known_node_version;


PATH="${PATH}:${HOME}/.nvm/versions/node/$node_version_to_use/bin"
unset node_version_to_use;

nvm() {
    export NVM_DIR="$HOME/.nvm"
    source "${NVM_DIR}/nvm.sh"

    nvm "$@" # invoke the real nvm function now
}