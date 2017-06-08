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
PROMPT=$'\n%{\e[47m\e[30m%} %T %{\e[37m\e[45m%} ${$(print -P "%4(c:.../:)%3c")//\\//  } %(1j.⚙.) %{\e[35m\e[40m%}%{\e[0m%}\n\$ '
ssh_prompt=$'\n%{\e[47m\e[30m%} %T %{\e[37m\e[44m%} ${$(print -P "%4(c:.../:)%3c")//\\//  } %(1j.⚙.) %{\e[34m\e[40m%}%{\e[0m%}\n\$ '
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  PROMPT=ssh_prompt
# many other tests omitted
else
  case $(ps -o comm= -p $PPID) in
    sshd|*/sshd) PROMPT=ssh_prompt
  esac
fi

setopt INC_APPEND_HISTORY
setopt HISTIGNOREDUPS
export HISTFILE=~/.zsh_history
export HISTSIZE=500
export SAVEHIST=500
export DIRSTACKSIZE=10
setopt autopushd pushdminus pushdsilent pushdtohome
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
#echo $WORDCHARS *?_-.[]~=/&;!#$%^(){}<>
export WORDCHARS=''
# consistent ctrl-u behaviour
bindkey \^U backward-kill-line

source ~/.zshrc.local
##-- alias --##
alias vi="vim"
alias view="vim -R"
alias la="ls -la"
alias ll="ls -lh"
alias dh="dirs -v"

##-- applications --##
# zsh-history-substring-search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# fasd
eval "$(fasd --init auto)"
alias v='f -e vim' # quick opening files with vim
bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)
bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (files and directories)

bindkey '^i' expand-or-complete-prefix
