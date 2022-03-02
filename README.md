# Configuration Files

These configuration files contain the current configuration of my computer.

The installation must be manual, but I working in a single script to install it in one step

## Installation scripts

- Run manually each command from `1_software/install.sh` file.
- Copy:
  - `2_config/.zshrc` to `~/.zshrc` 
  - `2_config/init.vim` to `~/.config/nvim/init.vim`
  - `2_config/plugins.vim` to `~/.config/nvim/plugins.vim` 
  - `2_config/tmuxinator.dev.yml` to `~/.config/tmuxinator/dev.yml`
- Open `nvim` and exec
  - `:PlugInstall`
  - `:CocInstall coc-go` 
- Change base xfce4 theme to `base16-Eighties` theme