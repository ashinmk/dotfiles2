export PATH="${HOME}/Scripts/bin:${HOME}/.toolbox/bin:$PATH"

source "$HOME/.dotconfig/early-env-setup/zsh-opts.sh";

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

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

zinit wait lucid light-mode for \
    atinit='zicompinit; zicdreplay' \
        zdharma/fast-syntax-highlighting \
    atload='_zsh_autosuggest_start' \
        zsh-users/zsh-autosuggestions \
    blockf atpull='zinit creinstall -q .' \
        zsh-users/zsh-completions


zinit wait lucid light-mode for atload='zsh-defer source "${HOME}/.dotconfig/lazy-init.sh"' romkatv/zsh-defer

zinit light-mode from="gh-r" as"program" id-as="fzf-bin" for junegunn/fzf;
zinit wait lucid depth="1" src="shell/key-bindings.zsh" for junegunn/fzf;

zinit wait lucid src=".iterm2_shell_integration.zsh" id-as="iterm2-shell-integration" for "${HOME}";

for initFile in $HOME/.dotconfig/*/init.sh; do
    source "$initFile"
done

for initFile in $HOME/.amazon.ext.dotconfig/*/init.sh; do
    source "$initFile"
done

for aliasFile in $HOME/.dotconfig/*/aliases.sh; do
    source "$aliasFile"
done

source ${HOME}/.starship-init.sh;

function benchmark_zsh() {
    hyperfine -w 20 -r 50 "zsh -i -c exit;";
}

#source ~/.zsh-prompt-benchmark/zsh-prompt-benchmark.plugin.zsh