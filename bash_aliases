#|
#| File          : ~/.bash_aliases
#| Last modified : 2013-01-03
#| Author        : Fabien Cazenave
#| Licence       : WTFPL
#| vim           : fdm=marker:fmr=<<<,>>>:fdl=0:ft=sh:
#|
#| These aliases are used by both bash and zsh (requires bash 4 or newer).
#| For zsh-specific aliases, use ~/.zshrc.
#|

# color support? (mostly because of gVim) <<<
case "$TERM" in
  xterm|xterm-color|rxvt-256color|screen|vt100)
    COLOR_TERM=$TERM;; # we know these terms have color support
  *)
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
      COLOR_TERM=$TERM # we seem to have color support:
                       # assume it's compliant with ECMA-48 (ISO/IEC-6429)
    fi;;
esac # >>>

# enable color support for ls and grep when possible <<<
if [ "$COLOR_TERM" ]; then
  # export GREP_COLOR='1;32'
  export GREP_OPTIONS='--color=auto'
  # find the option for using colors in ls, depending on the version: GNU or BSD
  ls --color -d . &>/dev/null 2>&1 \
    && alias ls='ls --group-directories-first --color=auto' \
    || alias ls='ls --group-directories-first -G' # BSD
else
  alias ls='ls --group-directories-first'
fi # >>>

# some handy ls aliases
alias l='ls -C'
alias la='ls -A'
alias ll='ls -lh'
alias lla='ls -alh'

# basic directory operations
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

# smart SSH agent: http://beyond-syntax.com/blog/2012/01/on-demand-ssh-add/
#       (see also: https://gist.github.com/1998129)
alias ssh='( ssh-add -l > /dev/null || ssh-add ) && ssh'
alias git-push='( ssh-add -l > /dev/null || ssh-add ) && git push'
alias git-pull='( ssh-add -l > /dev/null || ssh-add ) && git pull'
alias git-fetch='( ssh-add -l > /dev/null || ssh-add ) && git fetch'

# add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i '\
'"$([ $? = 0 ] && echo terminal || echo error)" '\
'"$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Vim <3 <3
alias v=vim
alias lr=ranger
alias :q=exit

# trick to define default arguments
# (only works when commands are typed manually in a shell)
alias less='less -F'
alias tmux='tmux -2'
alias gjslint='gjslint --nojsdoc'
alias nautilus='nautilus --no-desktop'

# __vcs_info: print branch for bzr/git/hg/svn version control in CWD <<<
# http://blog.grahampoulter.com/2011/09/show-current-git-bazaar-or-mercurial.html
function __vcs_info {
  local dir="$PWD"
  local logo="#"
  local vcs
  local branch
  while [[ "$dir" != "/" ]]; do
    for vcs in git hg svn bzr; do
      if [[ -d "$dir/.$vcs" ]] && hash "$vcs" &>/dev/null; then
        case "$vcs" in
          git)
            # if type __git_ps1 > /dev/null 2>&1; then
            #   __git_ps1 "${1:-[± %s] }"; return # use __git_ps1 when available
            # fi
            logo="±"; branch=$(git branch 2>/dev/null | grep ^\* | sed s/^\*.//);;
          hg)
            logo="☿"; branch=$(hg branch 2>/dev/null);;
          svn)
            logo="‡"; branch=$(svn info 2>/dev/null\
                | grep -e '^Repository Root:'\
                | sed -e 's#.*/##');;
          bzr)
            local conf="${dir}/.bzr/branch/branch.conf" # normal branch
            [[ -f "$conf" ]] && branch=$(grep -E '^nickname =' "$conf" | cut -d' ' -f 3)
            conf="${dir}/.bzr/branch/location" # colo/lightweight branch
            [[ -z "$branch" ]] && [[ -f "$conf" ]] && branch="$(basename "$(< $conf)")"
            [[ -z "$branch" ]] && branch="$(basename "$(readlink -f "$dir")")";;
        esac
        # optional $1 of format string for printf, default "‡ [%s] "
        [[ -n "$branch" ]] && printf "${1:-[$logo %s] }" "$branch"
        return 0
      fi
    done
    dir="$(dirname "$dir")"
  done
} # >>>

