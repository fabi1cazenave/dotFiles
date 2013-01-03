#|
#| File          : ~/.bash_aliases
#| Last modified : 2013-01-03
#| Author        : Fabien Cazenave
#| Licence       : WTFPL
#|

# some handy ls aliases
alias lla='ls -alh'
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -C'

# smart SSH agent: http://beyond-syntax.com/blog/2012/01/on-demand-ssh-add/
#       (see also: https://gist.github.com/1998129)
alias ssh='( ssh-add -l > /dev/null || ssh-add ) && ssh'
alias gpush='( ssh-add -l > /dev/null || ssh-add ) && git push'
alias gpull='( ssh-add -l > /dev/null || ssh-add ) && git pull'
alias gfetch='( ssh-add -l > /dev/null || ssh-add ) && git fetch'

# add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Vim rulez
alias v=vim
alias lr=ranger
alias :q=exit

# trick to define default arguments
alias less='less -F'
alias nautilus='nautilus --no-desktop'
alias tmux='tmux -2'
alias gjslint='gjslint --nojsdoc'

