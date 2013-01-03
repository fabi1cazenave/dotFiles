#|
#| File          : ~/.bashrc
#| Last modified : 2013-01-03
#| Author        : Fabien Cazenave
#| Licence       : WTFPL
#| vim           : fdm=marker:fmr=<<<,>>>:fdl=0:
#|
#| ~/.bashrc: executed by bash(1) for non-login shells.
#| See /usr/share/doc/bash/examples/startup-files for examples
#| (in the bash-doc package)
#|
#| This is Ubuntu's default ~/.bashrc with a couple tweaks.
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
#|    Prompt                                                                <<<
#|=============================================================================

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

# prompt parts
PS_chroot="${debian_chroot:+($debian_chroot)}"
PS_host="\u@\h:\w"
if [ "$color_prompt" = yes ]; then
  PS_host="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]"
fi

# simple prompt
# PS1="\t ${PS_chroot}${PS_host}"'\n\$ '

# simple prompt with current git branch
# GIT_PS1_SHOWDIRTYSTATE=yes
# PS1="\t ${PS_chroot}${PS_host} \$(__git_ps1 ["%s"])"'\n\$ '

# prompt with current git/hg/svn/bzr branch <<<
# http://blog.grahampoulter.com/2011/09/show-current-git-bazaar-or-mercurial.html
function be_get_branch {
  local dir="$PWD"
  # Print nickname for git/hg/bzr/svn version control in CWD
  # Optional $1 of format string for printf, default "[%s] "
  local logo="#"
  local vcs
  local nick
  while [[ "$dir" != "/" ]]; do
    for vcs in git hg svn bzr; do
      if [[ -d "$dir/.$vcs" ]] && hash "$vcs" &>/dev/null; then
        case "$vcs" in
          git) __git_ps1 "${1:-[± %s] }"; return;;
          hg) logo="☿"; nick=$(hg branch 2>/dev/null);;
          svn) logo="‡"; nick=$(svn info 2>/dev/null\
                | grep -e '^Repository Root:'\
                | sed -e 's#.*/##');;
          bzr)
            local conf="${dir}/.bzr/branch/branch.conf" # normal branch
            [[ -f "$conf" ]] && nick=$(grep -E '^nickname =' "$conf" | cut -d' ' -f 3)
            conf="${dir}/.bzr/branch/location" # colo/lightweight branch
            [[ -z "$nick" ]] && [[ -f "$conf" ]] && nick="$(basename "$(< $conf)")"
            [[ -z "$nick" ]] && nick="$(basename "$(readlink -f "$dir")")";;
        esac
        [[ -n "$nick" ]] && printf "${1:-[$logo %s] }" "$nick"
        return 0
      fi
    done
    dir="$(dirname "$dir")"
  done
}
# >>>
PS1="\t ${PS_chroot}${PS_host} \$(be_get_branch "$2")"'\n\$ ';

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

# >>>


#|=============================================================================
#|    Personal settings                                                     <<<
#|=============================================================================

# alias definitions
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  source /etc/bash_completion
fi

# autojump <3
if [ -f /usr/share/autojump/autojump.bash ]; then
  source /usr/share/autojump/autojump.bash
fi

# Vim <3 <3
set -o vi

# prevent ^S and ^Q doing XON/XOFF (mostly for Vim)
#stty -ixon

# >>>

