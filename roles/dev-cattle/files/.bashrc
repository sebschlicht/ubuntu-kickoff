# just assume colors are supported
PS1="\[\033[38;5;2m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;10m\]\h\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;33m\]\w\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;11m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\]\\$ \[$(tput sgr0)\]"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
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

# node.js
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
