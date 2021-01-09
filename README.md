- [Introduction](#introduction)
- [Code Organization](#code-organization)
- [Reusing Config](#reusing-config)


## Introduction
This serves as a backup of gauthamw@'s dotfiles. Pretty much all config that is stored and read from files is available here. Works with MacOS and Linux (AL2012/AL2).

While this is primarily focused on dotfiles, it does contain most of what is required to setup one's dev environment including apps.

## Code Organization

- **Top-level setup/bootstrap scripts** lie inside the `dotconfig` folder.
  - In the interest of simplifying changes, application install scripts (like `brew install`) which take time are separated from the config setup (symlinking/copying of config files).
  - **App-specific bootstrap scripts** are maintained in `bootstrap.sh` scripts inside the app-specific folders inside `dotconfig`.
- All configurations lie inside application-specific folders inside the `dotconfig` folder. This includes config for CLI app settings (eg: git) and MacOS GUI apps (iTerm2, Hammerspoon).
  - As part of bootstrap, this directory will be symlinked to `~/.dotconfig` to simplify references from other scripts.

## Reusing Config
As a general note, I recommend copying over config as applicable rather than using as-is. The general structure is documented and script-specific documentation is available to enable simplified extraction of specific scripts.
