- [Introduction](#introduction)
- [Pre-Requisites](#pre-requisites)
- [Getting Started](#getting-started)
  - [Overview of Steps](#overview-of-steps)
  - [Application Install](#application-install)
  - [Workspace Setup](#workspace-setup)
  - [Config Setup](#config-setup)

## Introduction
While the repo calls itself a Dotfile repo, it actually consists of most of what I need to get a laptop up and running. This setup has been split into two parts -
1. Application Installation
2. Dotconfig setup (Depends on #1)

This is an opinionated setup that works quite well for me. While I am open to reviewing contributions or fixes, I give no guarantee I'll accept them if the changes reduce my personal productivity :)

Note that I have stopped using Homebrew Cask in favour of MAS and direct installs as it makes tracking apps easier for me. I had a more detailed explanation for this but forgot to write it down. Feel free to disagree with this choice.

## Pre-Requisites
1. Builder Toolbox (installed by default or Self-Service)
   1. Check [here](https://builderhub.corp.amazon.com/docs/builder-toolbox/user-guide/getting-started.html) if not already installed.
2. (Amazon Apps only) mwinit (installed by default)
3. (Amazon Apps only) VPN or Corp net access.

## Getting Started
### Overview of Steps
1. Clone this package from git to any temporary directory. `git clone --depth 1 ssh://git.amazon.com/pkg/Gauthamw_dotfiles`
2. Install Apps as recommended in the Application Setup section. **Do not setup config yet.**
3. Setup a workspace dir following the Workspace Setup section.
4. Go to your workspace parent dir (~/ws), create a new workspace and then checkout this package via brazilcli. Maintaining the package as a normal brazil package is easier than as an isolated git repo.
    ```
    cd ~/ws;
    brazil ws create -n Dotfiles -vs live;
    cd Dotfiles;
    brazil ws use -p Gauthamw_dotfiles;
    cd Gauthamw_dotfiles;
    ```
5. Delete the repo pulled in step #1.
6. Proceed to Config Install section.

### Application Install
All apps to be installed (via Brew, Yum etc.) are covered in `install-apps.sh`. You would rarely need to rerun this script.

This script invokes `install-amazon-apps.sh` which triggers a Kerberos and Midway auth first. If you are not on VPN, you can always sign in later and then rerun this script.

### Workspace Setup
If you are using a Mac, you'll need a case-sensitive drive for development. Run `setup-case-sensitive-volumes-for-mac.sh` to setup a workspace in `/Volumes/workplace` or `~/ws`.

If you're setting it up on a dev-desktop, a new empty dir in `~/ws` will do.

### Config Setup
> This depends on app setup being complete. Do not start here.

The dotconfig dir which hosts all the dotfiles will be symlinked to $HOME/.dotconfig. Any existing link to this dir will be removed. This will serve as the entry point to the config files. This allows you to keep your repo anywhere but still have a static reference for your scripts.

As part of installation, app-level bootstrap files (`bootstrap.sh`) inside dotconfig are run. There is no guarantee that these won't modify existing config.