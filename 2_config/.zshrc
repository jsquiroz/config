export EDITOR='nvim'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="clean"

plugins=(git zsh-autosuggestions sudo copypath copyfile copybuffer history zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

alias vi='nvim'
alias vim='nvim'