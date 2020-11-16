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