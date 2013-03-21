#|
#| File    : ~/.zshrc
#| Source  : https://github.com/fabi1cazenave/dotFiles
#| Licence : WTFPL
#|
#| Warning: this file expects ~/.bash_aliases to define $COLOR_TERM.
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
# bindkey -v

# >>>

#|=============================================================================
#|    Key bindings (mostly compatible with ~/.inputrc)                      <<<
#|=============================================================================
# zsh key bindings to use when not in Vim mode -- `man zshzle` can be useful!

bindkey -e

# [Ctrl|Alt]+arrows (not working?)
bindkey "^[[1;5C" forward-word
bindkey "\e[1;3C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "\e[1;3D" backward-word

# Vim-style word movement: Alt+[w|e|b]
bindkey "\ew" forward-word
bindkey "\ee" forward-word
bindkey "\eb" backward-word

# home/end keys
bindkey "^[[H"  beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OH"  beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF"  end-of-line

# Vim-style home/end: Alt+[h|l]
bindkey "\eh"   beginning-of-line
bindkey "\el"   end-of-line

# delete key
bindkey '^?'     backward-delete-char
bindkey "^[[3~"  delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~"  delete-char

# Alt+r/s instead of Ctrl+r/s
bindkey "\er" history-incremental-search-backward
bindkey "\es" history-incremental-search-forward

# Vim-style history search: Alt+[j|k]
bindkey "\ek" up-line-or-search
bindkey "\ej" down-line-or-search
# bindkey '\ep' up-line-or-history
# bindkey '\en' down-line-or-history

# Oh-my-zsh stuff
# bindkey -s "\el" "ls\n"
bindkey '^[[Z' reverse-menu-complete
bindkey ' ' magic-space    # also do history expansion on space

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
# RPROMPT="$(__vcs_info)" # defined in ~/.bash_aliases
RPROMPT='${vcs_info_msg_0_}'
PROMPT="${PS_time} ${PS_user}:${PS_cwd}
${PS_prompt}"

# >>>

#|=============================================================================
#|    History                                                               <<<
#|=============================================================================

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

# >>>

#|=============================================================================
#|    Directory stack                                                       <<<
#|=============================================================================

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

# >>>

#|=============================================================================
#|    Auto-completion                                                       <<<
#|=============================================================================
# stolen from ~/.oh-my-zsh/lib/completion.zsh

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

WORDCHARS=''

zmodload -i zsh/complist

## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

zstyle ':completion:*' list-colors ''

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# use /etc/hosts and known_hosts for hostname completion
[ -r /etc/ssh/ssh_known_hosts ] && _global_ssh_hosts=(${${${${(f)"$(</etc/ssh/ssh_known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _global_ssh_hosts=()
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
  "$_global_ssh_hosts[@]"
  "$_ssh_hosts[@]"
  "$_etc_hosts[@]"
  "$HOST"
  localhost
)
zstyle ':completion:*:hosts' hosts $hosts

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH/cache/

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs

# ... unless we really want to.
zstyle '*' single-ignored show

if [ "x$COMPLETION_WAITING_DOTS" = "xtrue" ]; then
  expand-or-complete-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots
fi

# >>>

# smart URLs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# vim: set fdm=marker fmr=<<<,>>> fdl=0 ft=zsh:
