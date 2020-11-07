function setup_rprompt_for_amazon() {
    local my_rprompt;
    local midway_refreshed_recently=(/tmp/.recently-authorized(Nmh-20));
    if [[ -z "$midway_refreshed_recently" ]]; then
        my_rprompt="%F{red}輦%f";
    else
        my_rprompt="%F{green}聯%f";
    fi;
    local ninja_dev_sync_running=(/tmp/.nds-running(Nms-10));
    if [[ -z "$ninja_dev_sync_running" ]]; then
        my_rprompt="$my_rprompt%F{red}罹%f";
    else
        my_rprompt="$my_rprompt%F{green}痢%f";
    fi;
    export RPROMPT="$my_rprompt";
}

precmd_functions+=(setup_rprompt_for_amazon)

function setup_nds_monitor_script() {
    echo 'while true; do
        touch "/tmp/.nds-monitor-running";
        nds_running=$(ps -f | rg ninja | rg -v rg);
        if [[ ! -z "$nds_running" ]]; then
            touch "/tmp/.nds-running";
        fi;
        sleep 5;
    done' > "$HOME/.nds-monitor.sh"
    chmod +x "$HOME/.nds-monitor.sh";
    touch -d "300 days ago" /tmp/.nds-running;
}

[[ -f "$HOME/.nds-monitor.sh" ]] || setup_nds_monitor_script;

##  Always start NDS Monitor if not running
local nds_monitor_running=(/tmp/.nds-monitor-running(Nms-10));
if [[ -z "$nds_monitor_running" ]]; then
    (nohup "$HOME/.nds-monitor.sh" > /tmp/nds-monitor.out 2>&1 &) 2>&1
fi;

function start_nds() {
    (nohup ninja-dev-sync > /tmp/ninja-dev-sync.out 2>&1 &) 2>&1
}

function auth() {
    if [[ "$HOST" =~ "^dev-dsk.*" ]]; then
        kinit -f && mwinit -o && touch "/tmp/.recently-authorized";
    else
        kinit -f && mwinit --aea && ssh-add && touch "/tmp/.recently-authorized";
    fi;
}