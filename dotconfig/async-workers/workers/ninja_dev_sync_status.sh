function is_nds_running() {
    local num_matches=$(ps -eaf | rg 'ninja-dev-sync' | wc -l);
    [[ "$num_matches" -gt 1 ]] && return 0 || return 1;
}

if is_nds_running; then
    echo 'export G_NINJA_DEV_SYNC_STATUS="RUNNING"';
else
    echo 'export G_NINJA_DEV_SYNC_STATUS="NOT_RUNNING"';
fi;