#|
#| File          : ~/.bashrc
#| Last modified : 2013-01-03
#| Author        : Fabien Cazenave
#| Licence       : WTFPL
#|
#| ~/.bashrc: executed by bash(1) for non-login shells.
#| See /usr/share/doc/bash/examples/startup-files for examples
#| (in the bash-doc package).
#|
#| This is mostly Ubuntu's default ~/.bashrc with a couple tweaks.
#| Warning: expects ~/.bash_aliases to define $COLOR_TERM and __vcs_info.
#|

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


#|=============================================================================
#|    Personal settings (mostly shared with ~/.zshrc)                       <<<
#|=============================================================================

# Load bash alias definitions
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

# Enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  source /etc/bash_completion
fi

# Autojump <3
if [ -f /usr/share/autojump/autojump.bash ]; then
  source /usr/share/autojump/autojump.bash
fi

# Vim <3 <3
# set -o vi

# Prevent ^S and ^Q doing XON/XOFF (mostly for Vim)
stty -ixon

# >>>


#|=============================================================================
#|    Prompt                                                                <<<
#|=============================================================================

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# prompt parts
PS_user="\u@\h"
PS_cwd="\w"
PS_chroot="${debian_chroot:+($debian_chroot)}"
PS_title="${PS_chroot}${PS_user}:${PS_cwd}"

# comment this line for a distraction-free prompt
# -- warning: $COLOR_TERM is defined in ~/.bash_aliases
color_prompt=$COLOR_TERM
if [ "$color_prompt" ]; then
  PS_user="\[\033[1;32m\]\u@\h\[\033[0m\]"
  PS_cwd="\[\033[1;34m\]\w\[\033[0m\]"
fi
unset color_prompt

# classic Debia/Ubuntu prompt
# PS1="${PS_chroot}${PS_user}:${PS_cwd}"'\$ '

# two-line prompt with time
# PS1="\t ${PS_chroot}${PS_user}:${PS_cwd}"'\n\$ '

# two-line prompt with time and current git branch
# GIT_PS1_SHOWDIRTYSTATE=yes
# PS1="\t ${PS_chroot}${PS_user}:${PS_cwd} \$(__git_ps1 ["%s"])"'\n\$ '

# two-line prompt with time and current bzr/git/hg/svn branch
# -- warning: __vcs_info is defined in ~/.bash_aliases
PS1="\t ${PS_chroot}${PS_user}:${PS_cwd} \$(__vcs_info "$2")"'\n\$ ';

# if this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*|vt100)
    PS1="\[\e]0;${PS_title}\a\]$PS1";;
esac

# >>>

# vim: set fdm=marker fmr=<<<,>>> fdl=0 ft=zsh:
