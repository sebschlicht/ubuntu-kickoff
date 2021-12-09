# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

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
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# run anacron in user mode
if [ -f "$HOME/etc/anacrontab" ]; then
  /usr/sbin/anacron -s -t "$HOME/etc/anacrontab" -S "$HOME/var/spool/anacron"
fi

# homebrew
if [ -d "$HOME/.linuxbrew/bin" ]; then
  PATH="$PATH:$HOME/.linuxbrew/bin"
fi

# kubernetes
export KUBECONFIG="$HOME/kubeconfig"

ksh () {
  kubectl exec --stdin --tty "$1" -- /bin/sh
}
_kgs_entry () {
  local secret=$( kubectl get secret "$1" -o go-template="{{index .data \"$2\"}}" )
  echo "$secret"
}
_kgs_entry_plain () {
  local plain=$( _kgs_entry "$1" "$2" | base64 -d )
  echo "$plain"
}
