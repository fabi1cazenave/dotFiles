#|
#| File          : ~/.zshrc
#| Last modified : 2013-01-07
#| Author        : Fabien Cazenave
#| Licence       : WTFPL
#|
#| Warning: this file expectes ~/.bash_aliases to define $COLOR_TERM.
#|


#|=============================================================================
#|    Personal settings (mostly shared with ~/.bashrc)                      <<<
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

#|=============================================================================
#|    Prompt                                                                <<<
#|=============================================================================

# version control
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg svn
zstyle ':vcs_info:*'    formats $PS_vcsinfo" [‡ %b]"
zstyle ':vcs_info:hg*'  formats $PS_vcsinfo" [☿ %b]"
zstyle ':vcs_info:git*' formats $PS_vcsinfo" [± %b]"
precmd() {
  vcs_info
}

# prompt parts
local PS_prompt="%# "
local PS_time="%D{%H:%M:%S}" # like "%* but uses a leading zero when needed
local PS_host="@$(hostname)"
local PS_user="%n$PS_host"
local PS_cwd="%~"
local PS_vcsinfo="%r/%S"

# comment this line for a distraction-free prompt <<<
# -- warning: $COLOR_TERM is defined in ~/.bash_aliases
local color_prompt=$COLOR_TERM
if [ "$color_prompt" ]; then
  autoload colors && colors
  PS_prompt="%{$fg_bold[white]%}$PS_prompt%{$reset_color%}"
  PS_host="%{$fg_bold[green]%}$PS_host%{$reset_color%}"
  # time: color coded by last return code
  PS_time="%(?.%{$fg[green]%}.%{$fg[red]%})$PS_time%{$reset_color%}"
  # user: color coded by privileges
  PS_user="%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%})$PS_user%{$reset_color%}"
  PS_cwd="%{$fg_bold[blue]%}$PS_cwd%{$reset_color%}"
  PS_vcsinfo="%{$fg[blue]%}$PS_vcsinfo%{$reset_color%}"
fi
unset color_prompt
# >>>

# two-line prompt with time + current vcs branch on the right
setopt prompt_subst
# RPROMPT='${vcs_info_msg_0_}'
RPROMPT="$(__vcs_info)" # defined in ~/.bash_aliases
PROMPT="${PS_time} ${PS_user}:${PS_cwd}
${PS_prompt}"

# >>>

#|=============================================================================
#|    Oh-my-zsh configuration                                               <<<
#|=============================================================================

ZSH=$HOME/.oh-my-zsh
source $ZSH/lib/completion.zsh
source $ZSH/lib/key-bindings.zsh

# history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# directory stack
setopt auto_cd
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'
alias d='dirs -v | head -10'

# smart URLs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# >>>

#vim: fdm=marker fmr=<<<,>>> fdl=0 ft=zsh:
