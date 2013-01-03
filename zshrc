#|
#| File          : ~/.zshrc
#| Last modified : 2013-01-03
#| Author        : Fabien Cazenave
#| Licence       : WTFPL
#| vim           : fdm=marker:fmr=<<<,>>>:fdl=0:
#|
#| See also ~/.oh-my-zsh/templates/zshrc.zsh-template
#|


#|=============================================================================
#|    Oh-my-zsh configuration                                               <<<
#|=============================================================================

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme to load -- look in $ZSH/themes/* or $ZSH/custom/themes/*
# ZSH_THEME="robbyrussell"
# ZSH_THEME="bira"
# ZSH_THEME="candy"
# ZSH_THEME="smt"
ZSH_THEME="sporty_256"
# ZSH_THEME="gnzh"
# ZSH_THEME="trapd00r"

# Display red dots waiting for completion
COMPLETION_WAITING_DOTS="true"

# Plugins to load -- look in $ZSH/plugins/* or $ZSH/custom/plugins/*
plugins=(git mercurial)

source $ZSH/oh-my-zsh.sh

# >>>


#|=============================================================================
#|    Personal settings                                                     <<<
#|=============================================================================

# Load bash alias definitions
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

# Autojump <3
if [ -f /usr/share/autojump/autojump.zsh ]; then
  source /usr/share/autojump/autojump.zsh
fi

# Vim <3 <3
bindkey -v

# >>>

