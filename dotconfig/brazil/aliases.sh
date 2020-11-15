# $1 - Version-set
# $2-... - Packages
function print-dependencies() {
    brazil vs printdependencies --versionset "$1" --packages "${@:2}" --consumers
}

function print-dependency-graph() {
    local dotFile="/tmp/${RANDOM}.dot";
    brazil vs printdependencies --versionset "$1" --packages "${@:2}" --consumers --format dot > "$dotFile";
    local pngFile="$HOME/Desktop/${RANDOM}.png";
    dot -Tpng "$dotFile" > "$pngFile" && open "$pngFile";
}

alias bb="brazil-build";
alias bba="bb assemble";
alias bbs="bb server";
alias bbc="bb clean";
alias bbt="bb test";
alias bbb="bb build";