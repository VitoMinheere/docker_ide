#!/bin/bash
stty -ixon # Disable ctrl-s and ctrl-q.
HISTSIZE= HISTFILESIZE= # Infinite history.
export HISTTIMEFORMAT="%d/%m/%y %T "
export EDITOR=nvim

# Set PS1 for terminals. Displays time, directory and git branch if in git folder
RED="\[$(tput setaf 1)\]"
GREEN="\[$(tput setaf 6)\]"
BLUE="\[$(tput setaf 4)\]"
WHITE="\[$(tput sgr0)\]"
BOLD="\[$(tput bold)\]"
export GITAWAREPROMPT=$HOME/.config/bash/git-aware-prompt
source "$HOME/.config/bash/git-aware-prompt/main.sh"
export PS1="${BOLD}${RED}[${WHITE}\t ${BOLD}${BLUE}\W${RED}]${GREEN}\$git_branch ${WHITE}"

[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Save current working dir
PROMPT_COMMAND='pwd > "${HOME}/.cwd" && find_git_branch; history -a'
# Change to saved working dir on load
[[ -f "${HOME}/.cwd" ]] && cd "$(< ${HOME}/.cwd)" || return

# Automatically start and stop ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        ssh-agent > ~/.ssh-agent-thing
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
        eval "$(<~/.ssh-agent-thing)"
fi

