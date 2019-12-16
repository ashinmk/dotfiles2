#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

## Dev-Desktop -> Can't change shell by default so source zsh at launch.
if [[ ($ZSH_VERSION == "4.3.11") && (-f /home/linuxbrew/.linuxbrew/bin/zsh) ]]; then
    if [[ (-o login) && (-o interactive) ]]; then
        # Only source if this is a login and interactive shell. Avoid for scripts like rsync
        exec /home/linuxbrew/.linuxbrew/bin/zsh -l
    fi
fi

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ("$SHLVL" -eq 1 && ! -o LOGIN) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprofile"
fi
