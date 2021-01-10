## Overview
App-specific config files are stored here.

## Code Organization
- `zsh*` files are present in `zsh/` dir.
- `bootstrap.sh` files are run as part of bootstrapping to setup config files as needed.
- `zshrc` is configured to initialize the files as below:
  - All `init.sh` files inside app folders are lazily *sourced* (not run) after terminal starts. These scripts will be done in ~5s of shell start.
  - All `init.eager.sh` files are *sourced* (not run) as part of shell startup. Only config that needs to be active within 1-2s of the terminal startup should be here.
  - I'd recommend starting with the `zsh/` dir to explore all config.
- By default, all `init` scripts should be independent of each other. However, some configurations need to be setup early for all scripts. These should go in `early-env-setup`.

## Development Conventions
### General
- To avoid hard-coding paths, variables are provided for common dirs. Use them exclusively for portability. The available variables are:
  - `$BRAZIL_WS_DIR` - Brazil Dir. Also available as `~w`.
  - `$DOTCONFIG_DIR` - Dotconfig Dir.
- All scripts are meant to be independent of each other. Try to avoid adding dependencies.

### Good-to-know
- When using ZLE to fill in commands, populate `BUFFER` with the required command and then `zle accept-line`.
  - If the command to be run has a dynamic part (eg: file), even though the correct command will be run, the terminal
    might show an incorrect command due to `zsh-auto-suggestions`. Use `zle autosuggest-clear` to avoid this.
- For commands to not be preserved in history (or available for auto-complete), start them with a space. (eg: ` ls` instead of `ls`).

## Performance
Keeping the shells fast to open is important. Some guidelines for ensuring no regressions are added are provided below -

### Benchmarking
- A useful function `benchmark_zsh` is provided to benchmark zsh startup time. This can be helpful to find the time it takes to startup the entire shell.
- To profile zsh startup, uncomment `SHOULD_PROFILE_ZSH_STARTUP="true";` from `zshrc.sh`
  - This should not be enabled when running benchmark_zsh.
- To benchmark prompt speed, `zsh-prompt-benchmark` is provided as a function.

### General Performance Suggestions
- Avoid forking (commands in `$()`) as much as possible as forking is slow in MacOS in particular. Use zsh inbuilts whereever possible.
- Wherever possible, avoid add eager-init files.
- For scripts that need to rerun often, consider using the async-workers to export their results rather than using zinit's periodic load.
