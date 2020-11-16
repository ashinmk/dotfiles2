function prompt_my_midway_status_worker() {
    if [[ ! -f $HOME/.midway/cookie ]] || (( $(rg "^#HttpOnly_midway-auth.amazon.com" $HOME/.midway/cookie | awk '{print $5}') < $(date +%s) )); then
        prompt_seg_midway_status="NOT_OK";
    else
        prompt_seg_midway_status="OK";
    fi;
}

## Loaded in p10k.zsh as loading into prompt-elements from zinit doesn't seem to work.
function prompt_my_midway_status() {
    if [[ "$prompt_seg_midway_status" == "OK" ]]; then
        p10k segment -s MIDWAY -f green -t "聯";
    elif [[ "$prompt_seg_midway_status" == "NOT_OK" ]]; then
        p10k segment -s NO_MIDWAY -f red -t "輦";
    fi;
}

function prompt_my_nds_status_worker() {
    if [[ -z "$(ps -eaf | rg ninja-dev-sync | rg -v rg)" ]]; then
        prompt_seg_nds_status="NOT_OK";
    else
        prompt_seg_nds_status="OK";
    fi;
}

function prompt_my_nds_status() {
    if [[ "$prompt_seg_nds_status" == "OK" ]]; then
        p10k segment -s NDS -f green -t "痢";
    elif [[ "$prompt_seg_nds_status" == "NOT_OK" ]]; then
        p10k segment -s NO_NDS -f red -t "罹";
    fi;
}

export BB_SERVERS_RUNNING=();
function prompt_my_bbserver_status_worker() {
    local bbServerProcessesRunning=$(ps -eaf | rg 'brazil-build server' | rg -v 'rg' | awk '{print $2}');
    if [[ ! -z "$bbServerProcessesRunning" ]]; then
        export BB_SERVERS_RUNNING=("${(@f)$(echo "$bbServerProcessesRunning" | xargs pwdx | rg "$BRAZIL_WS_DIR/[^/]+" -o | rev | cut -d '/' -f 1 | rev | sort | uniq)}")
    fi;
}

function prompt_my_bbserver_status() {
    if [[ $PWD != $BRAZIL_WS_DIR/* ]]; then
        p10k segment -s NA -t "";
        return;
    fi;
    local currentWSName=$(pwd | sed "s:$BRAZIL_WS_DIR/::g" | cut -d '/' -f 1);
    if [[ ${BB_SERVERS_RUNNING[(ie)$currentWSName]} -le ${#BB_SERVERS_RUNNING} ]]; then
        p10k segment -s SERVER_RUNNING -f green -t "";
    else
        p10k segment -s SERVER_NOT_RUNNING -f red -t "";
    fi;
}