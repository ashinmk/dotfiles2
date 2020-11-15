local brew_env_file="${HOME}/.brew-env.sh";

function setup_brew_env() {
    local brewExec;
    local pasteExec;
    local brewGnuSearchPath;
    if [[ "$OSTYPE" == darwin* ]]; then
        brewExec="/usr/local/bin/brew";
        brewGnuSearchPath="/usr/local/opt";
        pasteExec="$brewGnuSearchPath/coreutils/libexec/gnubin/paste";
    else
        brewExec="/home/linuxbrew/.linuxbrew/bin/brew";
        pasteExec="paste";
        brewGnuSearchPath="/home/linuxbrew/.linuxbrew/opt";
    fi
    "${brewExec}" shellenv > "$brew_env_file";
    local gnubin_paths=$(find $brewGnuSearchPath -type d -follow -name gnubin -print 2> /dev/null | $pasteExec -s -d ':');
    if [[ ! -z "$gnubin_paths" ]]; then
        echo "export PATH=\"${gnubin_paths}:\$PATH\"" >> "$brew_env_file";
    fi;
}

if [[ (! -f "$brew_env_file") ]]; then
    setup_brew_env;
fi;

source "$brew_env_file";