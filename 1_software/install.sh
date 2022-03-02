#!/bin/bash

############
sudo apt install git zsh curl neovim xclip xsel tmux tmuxinator

##############
# change shell
##############
chsh -s `which zsh`
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

##############
# pluggins zsh
##############
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

##############
# theme terminal

mkdir -p ~/.local/share/xfce4/terminal/colorschemes
git clone https://github.com/afq984/base16-xfce4-terminal.git
cp base16-xfce4-terminal/colorschemes/*.theme ~/.local/share/xfce4/terminal/colorschemes

git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

# nvim
mkdir ~/.config/nvim