## Loaded in p10k.zsh as loading into prompt-elements from zinit doesn't seem to work.
function prompt_my_midway_status() {
    if [[ "$G_MIDWAY_STATUS" == "AUTHORIZED" ]]; then
        p10k segment -s MIDWAY -f green -t "聯";
    elif [[ "$G_MIDWAY_STATUS" == "NOT_AUTHORIZED" ]]; then
        p10k segment -s NO_MIDWAY -f red -t "輦";
    fi;
}

function prompt_my_nds_status() {
    if [[ "$G_NINJA_DEV_SYNC_STATUS" == "RUNNING" ]]; then
        p10k segment -s NDS -f green -t "痢";
    elif [[ "$G_NINJA_DEV_SYNC_STATUS" == "NOT_RUNNING" ]]; then
        p10k segment -s NO_NDS -f red -t "罹";
    fi;
}

function prompt_my_bbserver_status() {
    if [[ $PWD != $BRAZIL_WS_DIR/* ]]; then
        p10k segment -s NA -t "";
        return;
    fi;
    local currentWSName=$(pwd | sed "s:$BRAZIL_WS_DIR/::g" | cut -d '/' -f 1);
    if [[ "$G_BB_SERVERS_RUNNING" = *${currentWSName}* ]]; then
        p10k segment -s SERVER_RUNNING -f green -t "";
    else
        p10k segment -s SERVER_NOT_RUNNING -f red -t "";
    fi;
}