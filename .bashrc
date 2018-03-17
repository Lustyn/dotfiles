#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
export GPG_TTY=$(tty)

. /home/justyn/torch/install/bin/torch-activate

cat ~/.cache/wal/sequences

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/justyn/google-cloud-sdk/path.bash.inc' ]; then source '/home/justyn/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/justyn/google-cloud-sdk/completion.bash.inc' ]; then source '/home/justyn/google-cloud-sdk/completion.bash.inc'; fi

exec fish
