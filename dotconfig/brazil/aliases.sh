# $1 - Version-set
# $2 - Comma-separated Packages
function print-dependencies() {
    brazil vs printdependencies --versionset "$1" --packages "$2" --consumers;
}

# $1 - Version-set
# $2 - Comma-separated Packages
function print-dependency-graph() {
    local versionSet="$1";
    local packages="$2";

    local graphDir="$HOME/Documents/brazil-graphs";
    mkdir -p "$graphDir";

    local dotFile="/tmp/${RANDOM}.dot";
    (brazil vs printdependencies --versionset "$versionSet" --packages "$packages" --consumers --format dot > "$dotFile") || return;
    local pngFile="BDG - ${versionSet:s/\//-} - $packages";
    pngFile="$graphDir/$pngFile.png";
    dot -Tpng "$dotFile" > "$pngFile" && open "$pngFile";
}

alias bb="brazil-build";
alias bba="bb assemble";
alias bbs="bb server";
alias bbc="bb clean";
alias bbt="bb test";
alias bbb="bb build";
