cite about-alias
about-alias 'custom aliases'

alias qutebrowser='open -a qutebrowser'
alias sb='source ~/.bashrc'
#alias avi_map_ext='avi_map_ext --use-tricky-mock -u foo -p bar'
#alias list_vs='list_vs --use-tricky-mock -u foo -p bar'
#alias get_vs_cert='get_vs_cert --use-tricky-mock -u foo -p bar'
#alias vaws='workon aws; complete -C 'aws_completer' aws'
#alias addawscreds='gimme-aws-creds --profile default && add-aws-creds'
#alias vim='/usr/local/Cellar/vim/8.1.1100/bin/vim'
#

# History alias
alias histg="history | grep"

# Disk usage
alias df='df -kTh'
alias du='du -kh'

# Displays what occured on this day
alias ftoday='grep -h -d skip `date +%m/%d` /usr/share/calendar/*'

# Sudo last command.
alias please='/usr/bin/sudo $(history -p !!)'
alias _="sudo"

alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias showreminders="cat ~/.reminder"

# Shortcuts to common directories
alias cdown="cd /Users/fhenriquez/Downloads"
alias cdinvs="cd ~/investigation"
alias cdmisc="cd ~/misc_scratch"

alias utcdate='TZ=utc date'
alias weather='curl wttr.in/01830'
alias mostcmd="cut -d ' ' -f1 ~/.bash_history | sort | uniq -
