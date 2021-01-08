function find_bb_server_processes() {
    ps -eaf | rg 'brazil-build server' | awk '{print $2 "%%%" $8}' | rg -v '%%%rg$' | cut -d '%' -f 1;
}

# $1 - Process Ids
function find_bb_server_names_for_processes() {
    echo "$1" | xargs pwdx | rg "$BRAZIL_WS_DIR/[^/]+" -o | rev | cut -d "/" -f 1 | rev | sort | uniq
}

function set_bb_servers_running() {
    local bbServerProcessesRunning="$(find_bb_server_processes)";
    if [[ ! -z "$bbServerProcessesRunning" ]]; then
        local server_names=$(find_bb_server_names_for_processes "$bbServerProcessesRunning" | paste -s -d ' ');
        echo "export G_BB_SERVERS_RUNNING=\"$server_names\"";
    else
        echo 'export G_BB_SERVERS_RUNNING=""';
    fi;
}

set_bb_servers_running;
