# better default
setopt no_share_history
PS1=$'[%n@%m:%/]\n%# '

# alias
alias vi="vim"
alias cat="ccat"
alias cal="gcal"

##-- Applications --##
# hh
# add this configuration to ~/.zshrc
export HISTFILE=~/.zsh_history  # ensure history file visibility
export HH_CONFIG=hicolor        # get more colors
bindkey -s "\C-r" "\eqhh\n"     # bind hh to Ctrl-r (for Vi mode check doc)

