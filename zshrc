##-- zplug --##
# git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "hlissner/zsh-autopair", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# Then, source plugins and add commands to $PATH
zplug load #--verbose

##-- better defaults --##
setopt PROMPT_SUBST
PROMPT=$'\n%{\e[47m\e[30m%} %T %{\e[37m\e[44m%} ${$(print -P "%4(c:.../:)%3c")//\\//  } %{\e[34m\e[40m%}%{\e[0m%}\n\$ '
setopt INC_APPEND_HISTORY
setopt HISTIGNOREDUPS
export HISTFILE=~/.zsh_history
export HISTSIZE=500
export SAVEHIST=500
zstyle ':completion:*' menu select
#echo $WORDCHARS *?_-.[]~=/&;!#$%^(){}<>
export WORDCHARS=''

source ~/.zshrc.local
##-- alias --##
alias vi="vim"
alias la="ls -la"
alias ll="ls -lh"

##-- applications --##
# zsh-history-substring-search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# fasd
eval "$(fasd --init auto)"
bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)
bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (files and directories)

