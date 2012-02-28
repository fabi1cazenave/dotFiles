#|
#| File          : ~/.profile
#| Last modified : 2012-02-25
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

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
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
export LANGUAGE="fr_FR:en"
export LC_MESSAGES="fr_FR.UTF-8"
export LC_CTYPE="fr_FR.UTF-8"
export LC_COLLATE="fr_FR.UTF-8"

# most is a nice, configurable pager
#export PAGER=most
#export MOST_EDITOR=vim

# vimpager is a shell script that uses Vim as a pager
export EDITOR=vim
export PAGER=vimpager

