# bashrc-cdk

Inspired and forked from https://github.com/jkwmoore/bashrc-jmoore

This repo provides shared bashrc/aliases plus host-specific overrides.

## Setup

1. Clone to `~/bashrc-cdk`
2. Run `~/bashrc-cdk/bash-setup.sh` to pull updates and append sources to `~/.bashrc`
3. Start a new shell or `source ~/.bashrc`

## Updating

- `bashupd` runs `bash-setup.sh` and reloads `~/.bashrc`
- If `git pull` fails, stash or commit local changes first

## Host mapping

- `bessemer`, `stanage`, `sharc`, `jade` map to `bashrc_*`, `bash_aliases_*`, and `sc_*`

## Shortcuts

- `al` lists aliases
- `alg` grep aliases
- `bl` lists function names in bashrc files
- `sc` shows shortcuts
- `bashrc`, `ale`, `sce` print edit URLs for GitHub
