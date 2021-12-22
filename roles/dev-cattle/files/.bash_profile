if [ -r ~/.profile ]; then
    . ~/.profile
fi

# if running bash
case "$-" in *i*) if [ -n "$BASH_VERSION" ] && [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
