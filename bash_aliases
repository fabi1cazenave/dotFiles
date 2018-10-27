#|
#| File    : ~/.bash_aliases
#| Author  : Fabien Cazenave
#| Source  : https://github.com/fabi1cazenave/dotFiles
#| Licence : WTFPL
#|
#| These aliases are used by both bash and zsh (requires bash 4 or newer).
#| For zsh-specific aliases, use ~/.zshrc.
#|

# color support? (mostly because of gVim) <<<
case "$TERM" in
  xterm*|rxvt*|screen|vt100)
    COLOR_TERM=$TERM;; # we know these terms have proper color support
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
alias ll='ls -lhH'
alias lla='ls -alhH'

# list files modified today
lmru() {
  find $1 -mtime -1 -print
}

# basic directory operations
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'

# Vim <3 Neovim <3 <3
# alias v="if [ -e .vimrc ]; then; vim -u .vimrc; else; vim; fi"
alias v=nvim
alias vi="vim -u NONE"
alias nvi="nvim -u NONE"
alias vimrc="vim ~/.vimrc"
alias nvimrc="nvim ~/.config/nvim/init.vim"
alias lr="[ $RANGER_LEVEL ] && exit || ranger"
alias :q=exit

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

# geekiest thing ever
alias weather='curl wttr.in/Grenoble'

# OSX style
alias open=xdg-open

# trick to define default arguments
# (only works when commands are typed manually in a shell)
alias less='less -F'
alias tmux='tmux -2'
# alias gjslint='gjslint --nojsdoc'
alias nautilus='nautilus --no-desktop'
alias nemo='nemo --no-desktop'

# CPU performance
alias watch_cpu="watch -n 1 'cat /proc/cpuinfo | grep -i mhz'"

# MRU
alias freq='cut -f1 -d" " $HISTFILE | sort | uniq -c | sort -nr | head -n 30'

# __vcs_info: print branch for bzr/git/hg/svn version control in CWD <<<
# http://blog.grahampoulter.com/2011/09/show-current-git-bazaar-or-mercurial.html
__vcs_info() {
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

# seconds <-> hh:mm:ss <<<
# Works with GNU sed (Linux…), not sure it works on OSX
__hms2sec() {
  # with sed and bc:
  echo $1 \
    | sed -E 's/(.*):(.+):(.+)/\1*3600+\2*60+\3/;s/(.+):(.+)/\1*60+\2/' \
    | bc
  # with awk:
  # num=`echo $1 | awk -F: '{ print NF-1 }'`
  # case "$num" in
  #   0) echo $1;;
  #   1) echo $1 | awk -F: '{ print $2 + $1*60 }';;
  #   2) echo $1 | awk -F: '{ print $3 + $2*60 + $1*3600 }';;
  # esac
}
__sec2hms() {
  # printf %02d:%02d:%02d\\n $(($1/3600)) $(($1%3600/60)) $(($1%60))
  # handling decimals:
  t=`echo $1 | sed -E 's/\..*$//'`
  d=`echo $1 | sed -E 's/^.*\.//'`
  if [ "$t" = "$1" ]; then
    printf %02d:%02d:%02d\\n $((t/3600)) $((t%3600/60)) $((t%60))
  else
    printf %02d:%02d:%02d.%d\\n $((t/3600)) $((t%3600/60)) $((t%60)) $d
  fi
}
# >>>

# vim: set fdm=marker fmr=<<<,>>> fdl=0 ft=sh:
