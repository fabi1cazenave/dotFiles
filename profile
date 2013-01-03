#|
#| File          : ~/.profile
#| Last modified : 2013-01-03
#| Author        : Fabien Cazenave
#| Licence       : WTFPL
#|
#| ~/.profile: executed by the command interpreter for login shells.
#| This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
#| exists.
#| See /usr/share/doc/bash/examples/startup-files for examples
#| (in the bash-doc package).
#|
#| This is Ubuntu's default ~/.profile with a couple tweaks.
#|

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# when running bash, include ~/.bashrc if it exists
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/Applications" ] ; then
    PATH="$HOME/Applications:$PATH"
fi
if [ -d "$HOME/Applications/sdk" ] ; then
    PATH="$HOME/Applications/sdk:$PATH"
fi

# I hate Java but...
export JAVA_HOME=~/Applications/sdk/jdk1.7.0_04/bin/
PATH="$JAVA_HOME:$PATH"

# most is a nice, configurable pager
#export PAGER=most
#export MOST_EDITOR=vim

# vimpager is a shell script that uses Vim as a pager
export EDITOR=vim
export PAGER=vimpager

