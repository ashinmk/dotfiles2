#################################################################################
#################################################################################
############################## Begin Framework Code #############################
export G_ASYNC_WORKER_DIR="$HOME/.dotconfig/async-workers";
export G_ASYNC_WORKER_OUTPUT_DIR="$HOME/.g-worker/outs";
export G_ASYNC_WORKER_OUTPUT_SRC_REL_DIR="src";
export G_ASYNC_WORKER_OUTPUT_SRC_MERGED_FILENAME="merged_src_out.sh";

function g_worker_initialize() {
    if [[ ! -d "$G_ASYNC_WORKER_OUTPUT_DIR/$G_ASYNC_WORKER_OUTPUT_SRC_REL_DIR" ]]; then
        mkdir -p "$G_ASYNC_WORKER_OUTPUT_DIR";
        mkdir -p "$G_ASYNC_WORKER_OUTPUT_DIR/$G_ASYNC_WORKER_OUTPUT_SRC_REL_DIR";
    fi;

    # Don't reuse src if old.
    local output_src_recently_updated=($G_ASYNC_WORKER_OUTPUT_DIR/$G_ASYNC_WORKER_OUTPUT_SRC_MERGED_FILENAME(Nms-30));
    if [[ -z "$output_src_recently_updated" ]]; then
        echo '' > "$G_ASYNC_WORKER_OUTPUT_DIR/$G_ASYNC_WORKER_OUTPUT_SRC_MERGED_FILENAME";
    fi;
}

####################################
# Check if a given process or file is running.
# $1 - File to check for.
####################################
function g_worker_is_process_running() {
    local target_file="$1";

    local num_matches=$(ps -eaf | rg -F "$target_file" | wc -l);
    if [[ "$num_matches" -gt 1 ]]; then
        return 0;
    else
        return 1;
    fi;
}

# Run Worker periodically with output to file.
# $1 = "Target Worker"
# $2 = "Period in seconds"
# $3 = "Output File"
#
function run_periodic_async() {
    local worker_name="$1";
    local time_period="$2";
    local output_file="$3";

    if g_worker_is_process_running "$worker_name"; then
        return 0;
    fi;
    (nohup "$G_ASYNC_WORKER_DIR/run-periodic" "$G_ASYNC_WORKER_DIR/workers/${worker_name}.sh" $time_period "$G_ASYNC_WORKER_OUTPUT_DIR/$output_file" &)  > /dev/null 2>&1
}

g_worker_initialize;
run_periodic_async "merge_output_src" 10 "merge_output_src.out";

function source_worker_output_src() {
    source "$G_ASYNC_WORKER_OUTPUT_DIR/$G_ASYNC_WORKER_OUTPUT_SRC_MERGED_FILENAME";
}

precmd_functions=(source_worker_output_src "${precmd_functions[@]}")

############################# End of Framework Code #############################
#################################################################################
#################################################################################

if [[ "$OSTYPE" == darwin* ]]; then
    run_periodic_async "ninja_dev_sync_status" 10 "$G_ASYNC_WORKER_OUTPUT_SRC_REL_DIR/nds_status";
else
    run_periodic_async "bb_server_tracker" 10 "$G_ASYNC_WORKER_OUTPUT_SRC_REL_DIR/bb_server_status";
fi;
run_periodic_async "midway_status" 60 "$G_ASYNC_WORKER_OUTPUT_SRC_REL_DIR/midway_status";