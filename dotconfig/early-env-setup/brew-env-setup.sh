local brew_env_file="${HOME}/.brew-env.sh";

function setup_brew_env() {
    brew shellenv > "$brew_env_file";
    local gnubin_paths=$(find /usr/local/opt -type d -follow -name gnubin -print 2> /dev/null | /usr/local/opt/coreutils/libexec/gnubin/paste -s -d ':');
    echo "export PATH=\"${gnubin_paths}:$PATH\"" >> "$brew_env_file";
}

if [[ (! -f "$brew_env_file") ]]; then
    setup_brew_env;
fi;

source "$brew_env_file";