#|
#| File          : ~/.bashrc
#| Last modified : 2012-04-08
#| Author        : Fabien Cazenave
#| Licence       : WTFPL
#|
#| ~/.bashrc: executed by bash(1) for non-login shells.
#| See /usr/share/doc/bash/examples/startup-files for examples
#| (in the bash-doc package)
#|
#| This is Ubuntu's default ~/.bashrc with a couple tweaks (mostly aliases).
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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm|xterm-color|rxvt-256color|screen|vt100)
    color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

# see also: http://www.askapache.com/linux/bash-power-prompt.html
if [ "$color_prompt" = yes ]; then
  PS1='\t ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(__git_ps1 ["%s"])\n\$ '
else
  PS1='\t ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(__git_ps1 ["%s"])\n\$ '
  #PS1='\t ${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 ["%s"])\n\$ '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|vt100)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*)
  ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  if [ "$color_prompt" = yes ]; then
    alias ls='ls --color=auto --group-directories-first'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi
fi
unset color_prompt force_color_prompt

# some more ls aliases
alias lla='ls -alh'
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -C'

# smart SSH agent: http://beyond-syntax.com/blog/2012/01/on-demand-ssh-add/
#                  (see also: https://gist.github.com/1998129)
alias ssh="( ssh-add -l > /dev/null || ssh-add ) && ssh"
alias gpush="( ssh-add -l > /dev/null || ssh-add ) && git push"
alias gpull="( ssh-add -l > /dev/null || ssh-add ) && git pull"
alias gfetch="( ssh-add -l > /dev/null || ssh-add ) && git fetch"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

# prevent ^S and ^Q doing XON/XOFF (mostly for Vim)
#stty -ixon

