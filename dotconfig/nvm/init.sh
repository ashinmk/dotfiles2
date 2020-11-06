local node_path_helper_location="$HOME/.node-path-helper.sh";
function setup_node_path_helper() {
    local node_version=$(cat ~/.nvm/alias/default);
    local node_command='export PATH="${PATH}:${HOME}/.nvm/versions/node/'$node_version'/bin"'
    echo "$node_command" > "$node_path_helper_location"
}

[[ -f ${node_path_helper_location} ]] || setup_node_path_helper;

local node_alias_updated_recently=(~/.nvm/alias/default(Nm-1)); # Updated in the last 1 day.
if [[ ! -z "$node_alias_updated_recently" ]]; then
    # Updated recently.
    setup_node_path_helper;
    touch -d "48 hours ago" ~/.nvm/alias/default;
fi;

source "$node_path_helper_location";

nvm() {
    export NVM_DIR="$HOME/.nvm"
    source /usr/local/opt/nvm/nvm.sh

    nvm "$@" # invoke the real nvm function now
}