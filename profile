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

export TZ=Europe/Paris
export TERMINAL=urxvt

# pager
export PAGER=less       # good old stuff, gets the job done
# export PAGER=most     # better alternative w/ highlighting (but unmaintained)
# export PAGER=vimpage  # shell script that uses Vim as a pagerr

# Neovim > Vim
if command -v nvim >/dev/null 2>&1; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

# ~/.XCompose
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# support all apps that have been installed to the user's private opt
# (note: $DYLD_LIBRARY_PATH is specific to OSX)
for dir in $HOME/.local/opt/*; do
  [ -d "$dir/bin" ]       && PATH="${dir}/bin:${PATH}"
  [ -d "$dir/sbin" ]      && PATH="${dir}/sbin:${PATH}"
  [ -d "$dir/include" ]   && CPATH="${dir}/include:${CPATH}"
  [ -d "$dir/share/man" ] && MANPATH="${dir}/share/man:${MANPATH}"
  if [ -d "$dir/lib" ]; then
    LD_RUN_PATH="${dir}/lib:${LD_RUN_PATH}"
    LD_LIBRARY_PATH="${dir}/lib:${LD_LIBRARY_PATH}"
    [ -n "$DYLD_LIBRARY_PATH" ] && DYLD_LIBRARY_PATH="${dir}/lib:${DYLD_LIBRARY_PATH}"
    [ -d "$dir/lib/pkgconfig" ] && PKG_CONFIG_PATH="${dir}/lib/pkgconfig:${PKG_CONFIG_PATH}"
  fi
done

# vim: set ft=sh:
