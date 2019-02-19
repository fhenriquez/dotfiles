#########################################################################
# Name: Franklin Henriquez                                              #
# Author: Franklin Henriquez (franklin.a.henriquez@gmail.com)           #
# Last Modified: 18Feb2019                                              #
# Description: Bash configuration file.                                 #
#                                                                       #
# Version: 1.2.1                                                        #
#                                                                       #
#########################################################################

# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

# Adding color codes
source ~/.bash_color_codes

# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

# add date/time to history file
#export HISTTIMEFORMAT="%m/%d/%y %T "
export HISTTIMEFORMAT="[%F %T] "

# Hostname appended to bash history filename
export HISTFILE="$HOME/.bash_history"

# History size
export HISTSIZE=
export HISTFILESIZE=

# Don't save repeated commands in bash history
export HISTCONTROL="ignoreboth"
export HISTIGNORE="ls:ps:history"

source ~/.bash_functions

# Make bash check its window size after a process completes
shopt -s checkwinsize

#[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"

# Add bin to path
export PATH="$PATH:$HOME/bin:/usr/local/sbin"
#export PATH="/usr/local/opt/openssl/bin:/usr/local/opt/python/libexec/bin:$PATH"

# Editor
export EDITOR='vim'

#==================================================#
# Starting Bash-it Config                          #
#==================================================#

# Path to the bash it configuration
export BASH_IT="/home/fhenriquez/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='sysadmin_binaryanomaly'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
# export BASH_IT_RELOAD_LEGACY=1

# Load Bash It
source "$BASH_IT"/bash_it.sh
