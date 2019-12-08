if [[ "$OSTYPE" == darwin* ]]; then
    export HOMEBREW_PREFIX="/usr/local";
else
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
fi

### Hard-code $(brew shellenv) to avoid repeated sub-shell calls
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar";
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew";
export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}";
export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="${HOMEBREW_PREFIX}/share/info${INFOPATH+:$INFOPATH}";

export PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:${HOMEBREW_PREFIX}/opt/findutils/libexec/gnubin:${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin:$PATH"

if [[ -d "${HOMEBREW_PREFIX}/opt/grep/libexec/gnubin" ]]; then
    export PATH="${HOMEBREW_PREFIX}/opt/grep/libexec/gnubin:$PATH"
fi
