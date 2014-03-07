#|
#| File    : ~/.profile
#| Author  : Fabien Cazenave
#| Source  : https://github.com/fabi1cazenave/dotFiles
#| Licence : WTFPL
#|
#| ~/.profile: executed by the command interpreter for login shells.
#|
#| This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
#| exists.  See /usr/share/doc/bash/examples/startup-files for examples
#| (in the bash-doc package).
#|

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# umask 022

# when running bash, include ~/.bashrc if it exists
if [ -n "$BASH_VERSION" ]; then
  [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
fi

# most is a nice, configurable pager
# export PAGER=most
# export MOST_EDITOR=vim

# vimpager is a shell script that uses Vim as a pager
export EDITOR=vim
export PAGER=vimpager

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# support all apps that have been installed to the user's private opt
for dir in $HOME/.local/opt/*; do
  [ -d "$dir/bin" ]       && PATH="${dir}/bin:${PATH}"
  [ -d "$dir/sbin" ]      && PATH="${dir}/sbin:${PATH}"
  [ -d "$dir/include" ]   && CPATH="${dir}/include:${CPATH}"
  [ -d "$dir/share/man" ] && MANPATH="${dir}/share/man:${MANPATH}"
  if [ -d "$dir/lib" ]; then
    LD_RUN_PATH="${dir}/lib:${LD_RUN_PATH}"
    LD_LIBRARY_PATH="${dir}/lib:${LD_LIBRARY_PATH}"
    # uncomment the following line on OSX
    # DYLD_LIBRARY_PATH="${dir}/lib:${DYLD_LIBRARY_PATH}"
    [ -d "$dir/lib/pkgconfig" ] && PKG_CONFIG_PATH="${dir}/lib/pkgconfig:${PKG_CONFIG_PATH}"
  fi
done

# I hate Java but...
# export JAVA_HOME="$HOME/.local/opt/jdk1.7.0_04/bin/"
# [ -d "$JAVA_HOME" ] && PATH="$JAVA_HOME:$PATH"

# ~/.XCompose
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim

