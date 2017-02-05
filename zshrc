##-- zplug --##
# git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

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
PS1=$'\n%{\e[47m\e[30m%} %T %{\e[37m\e[44m%}'" ${$(print -P "%4(c:.../:)%3c")//\//  } "$'%{\e[34m\e[40m%}%{\e[0m%}\n\$ '
zstyle ':completion:*' menu select

##-- alias --##
alias vi="vim"
alias ls="ls -G"
alias la="ls -la"
alias ll="ls -l"
alias cat="ccat"
alias cal="gcal"

##-- applications --##
# hh
export HISTFILE=~/.zsh_history  # ensure history file visibility
export HH_CONFIG=hicolor        # get more colors
bindkey -s "\C-r" "\eqhh\n"     # bind hh to Ctrl-r (for Vi mode check doc)

# fasd
eval "$(fasd --init auto)"
alias jj="zz"
bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)
bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (files and directories)
