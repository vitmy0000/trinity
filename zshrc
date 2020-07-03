##-- zplug {{{--
# git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
zplug "plugins/wd", from:oh-my-zsh
zplug "zsh-users/zsh-history-substring-search"
zplug "agkozak/zsh-z"
zplug "Aloxaf/fzf-tab", defer:2
zplug "hlissner/zsh-autopair", defer:3
zplug "zsh-users/zsh-autosuggestions", defer:3
zplug "zsh-users/zsh-syntax-highlighting", defer:3

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
# Then, source plugins and add commands to $PATH
zplug load #--verbose
##}}}

##-- setup {{{--
# append the follow lines to .bashrc
# to set default shell to zsh without root permission
: <<'END'
export SHELL=$(which zsh)
[ -z "$ZSH_VERSION" ] && exec "$SHELL" -l
END
# export this variable so to enable bash sub-shell
export ZSH_VERSION=$ZSH_VERSION
# default editor
export EDITOR=vim
##}}}

##-- history {{{--

##-- cmd history {{{--
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
# append history without waiting until the shell exits
setopt INC_APPEND_HISTORY
# do not enter command lines into the history list
# if they are duplicates of the previous event.
setopt HIST_IGNORE_DUPS
##}}}

##-- dir history {{{--
setopt AUTO_CD
# dir history stack
setopt AUTO_PUSHD PUSHD_MINUS PUSHD_SILENT PUSHD_TO_HOME
export DIRSTACKSIZE=10
##}}}

##}}}

##-- completion {{{--
autoload -U compinit
compinit
# allow completion from within a word/phrase
setopt complete_in_word
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
##}}}

##-- alias {{{--
platform='unknown'
case "$OSTYPE" in
  solaris*) platform="SOLARIS" ;;
  darwin*)  platform="OSX" ;;
  linux*)   platform="LINUX" ;;
  bsd*)     platform="BSD" ;;
  msys*)    platform="WINDOWS" ;;
  *)        platform="unknown: $OSTYPE" ;;
esac
if [[ $platform == 'LINUX' ]]; then
   alias ls='ls --color=auto'
elif [[ $platform == 'OSX' ]]; then
   alias ls='ls -G'
fi
alias vi='vim'
alias la='ls -a'
alias ll='ls -alh'
alias so='source ~/.zshrc'
# cmd history sync
alias hs='fc -R'
# shell level
alias sl='echo $SHLVL'
##}}}

##-- keybindings {{{--
# consistent ctrl-u behaviour
export WORDCHARS=
bindkey -e
bindkey '^u' backward-kill-line
##}}}

##-- plugins {{{--

##-- powerlevel9k {{{--
POWERLEVEL9K_DIR_PATH_SEPARATOR=" $(print_icon "LEFT_SUBSEGMENT_SEPARATOR") "
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="$ "
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=('status' 'time' 'dir' 'vcs' 'background_jobs' 'anaconda')
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_STATUS_OK_BACKGROUND='237'
# show color
: <<'END'
for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
END
##}}}

##-- zsh-history-substring-search {{{--
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
##}}}

##-- fzf {{{--
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
##}}}

##-- zsh-z {{{--
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && zshz "$*" && return
  cd "$(zshz -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}
##}}}

##}}}

##-- misc {{{--
# for emacs-babel
[ $TERM = "dumb" ] && unsetopt zle && PS1='$ '

# path
export PATH="$HOME/bin:$PATH"
##}}}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/vagrant/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/vagrant/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/vagrant/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/vagrant/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

