#########################################################################
# Name: Franklin Henriquez                                              #
# Author: Franklin Henriquez (franklin.a.henriquez@gmail.com)           #
# Last Modified: 18Feb2019                                              #
# Description: Bash file, fille with basic functions.			#
#                                                                       #
# Version: 2.0.1                                                        #
#                                                                       #
#########################################################################

# Importing colors
source ~/.bash_color_codes

#########################################################################################
#                                                                                       #
# System Info gathering                                                                 #
#                                                                                       #
#########################################################################################

# What is my OS. 

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    OS=RedHat
    VER=$(cat /etc/redhat-release | awk '{print $7}')
elif sw_vers >/dev/null 2>&1; then
    OS="Mac OS X"
    VER=$(sw_vers | grep ProductVer | cut -d : -f 2)
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

# Does not work on mobaXTerm commented out
# Get internal an external IP. 
# uses ip or ifconfig, good on older or newer system
m-ip()
{
        echo "--------------- Network Information ---------------"
#    # newer system like arch
#    ip addr | awk '/global/ {print $1,$2}' | cut -d\/ -f1
#    ip addr | awk '/global/ {print $3,$4}'
#    ip addr | awk '/ether/ {print $1,$2}'
#    ip addr | awk '/scope link/ {print $1,$2}' | cut -d\/ -f1
    # mac osx
        ifconfig en0 | awk '/inet / {print $1,$2}' | awk -F: '{print $1,$2}'
        ifconfig en0 | awk '/inet addr/ {print $5,$6}' | awk -F: '{print $1,$2}'
        ifconfig en0 | awk '/ether/ {print "MAC address",$2}'
        echo Current IP $(curl -s http://checkip.dyndns.org/ | grep -o "[[:digit:].]\+")
        echo "---------------------------------------------------"
}

# Get current host relate info. Work on the MAC OS version.
ii()
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$Color_Off " ; uname -a
    echo -e "\n${BRed}Users logged on:$Color_Off " ; w -hs | cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$Color_Off " ; date
    echo -e "\n${BRed}Machine stats :$Color_Off " ; uptime
    echo -e "\n${BRed}Memory stats :$Color_Off " ; 
        if [ "$OS" == "Mac OS X" ]
        then 
            top -l 1 -s 0 | grep PhysMem 
        else 
            free -m
        fi
    echo -e "\n${BRed}Diskspace :$Color_Off " ; df / $HOME
    echo -e "\n${BRed}Local IP Address :$Color_Off" ; my_ip
    echo -e "\n${BRed}Open connections :$Color_Off "; netstat -int;
    echo
}

#########################################################################################
#                                                                                       #
# Productiviy Functions                                                                 #
#                                                                                       #
#########################################################################################

# Extract compressed file or folder.
# Usage: ex <tar_file>
ex () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1        ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       rar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xf $1        ;;
            *.tbz2)      tar xjf $1      ;;
            *.tgz)       tar xzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
	    *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Create a ZIP archive of a file or folder.
# Usage: mkzip <directory>
makezip()
{ 
    zip -r "${1%%/}.zip" "$1" ; 
}


# Create a TAR archive of a file or folder.
# Usage: mktar <directory>
mktar()
{ 
    tar czf "${1%%/}.tar.gz" "${1%%/}/"; 
}

# Easier Basic Calculator
# Usage: calc NUM1 (-,+,*,**,/) NUM2 
calc()
{ 
    echo "$*" | bc; 
}


# mcd - creates a new directory and moves into it,
# Usage: mcd <directory>
mcd()
{
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

# cd and ls a directory at the same time
# Usage: cdl <directory>
cdl()
{
    cd -- "$@" && ls
}

# Own file 
# Usage: mkmine <file>
mkmine()
{ 
    sudo chown -R ${USER} ${1:-.}; 
}

# sanitize - set file/directory owner and permissions to normal values (644/755)
# Usage: sanitize <file>
sanitize()
{
    chmod -R u=rwX,go=rX "$@"
    chown -R ${USER}.users "$@"
}

# Time Functions

# Its the final countdown!
# Usage: countdown HH:MM:SS
countdown()
(
    if [ "$#" -eq 0 ]
    then
        echo -e "
        \rUsage countdown hours:min:secs
        \rDescription: Simple countdown function.
        "
        return 1    
    else

    IFS=:
    set -- $*
    secs=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))
    while [ $secs -gt 0 ]
    do
      sleep 1 &
      printf "${Red}\r%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
      secs=$(( $secs - 1 ))
      wait
    done
    echo -e ${Color_Off}
    fi
)

# Can't stop wont stop.
# Usage: stopwatch
stopwatch()
{
    local BEGIN=$(date +%s)
    #local BEGIN="1536176603"
    echo -e "${Cyan}Starting Stopwatch..."

    while true; do
        local NOW=$(date +%s)
        local DIFF=$(($NOW - $BEGIN))
        local MINS=$(($DIFF / 60))
        
        # Checking to see if minutes is greater than an hour.
        if [ "$MINS" -ge 60 ]; 
        then 
            local MINS=$(($MINS % 60))
        fi

        local SECS=$(($DIFF % 60))
        local HOURS=$(($DIFF / 3600))
        local DAYS=$(($DIFF / 86400))

        printf "${Red}\r%3d Days, %02d:%02d:%02d${NC}" $DAYS $HOURS $MINS $SECS
        sleep 0.5
    done
    echo 
}

# clock - A bash clock that can run in your terminal window.
clock ()
{
while true;do clear;echo "===========";date +"%r";echo "===========";sleep 1;done
}

# Weather functions
wttr()
{
 curl wttr.in/"$1";
}

sweather()
{
    curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-<01830>}"| xmlstarlet sel -t -m "//forecast/txt_forecast/forecastday" -v $'concat(title,": " , fcttext, "\n")' -n;
    #curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-<01830>}"|perl -ne '/<title>([^<]+)/&&printf "%s: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"';

}

# Rough function to display the number of unread emails in your gmail:
gmail()
{
    if [ "$#" -eq 0 ]
    then
        echo -e "
        \rUsage gmail [user name]
        \rDescription: Display the number of unread emails in your gmail.
        "
        return 1    
    else
        curl -u "$1" --silent "https://mail.google.com/mail/feed/atom" | sed -e 's/<\/fullcount.*/\n/' | sed -e 's/.*fullcount>//'
    fi
}


# Dictionary
# Usage: dict <word>
#dict()
#{
#    curl dict://dict.org/d:"${1}"
#}

# Start my day.
startmyday()
{
    brewit=0;
    news_1="bbc-news"
    news_2="hacker-news"
    nameuser="Franklin"

    # USAGE
    usage(){
        echo -e "
        \rUsage: $0 [options]
        \rDescription:\tThe script will gather the news.

        \roptional arguments:
        \r-b\tUpdate homebrew.
        \r-h\tShow this help message and exit."
    }

    # Check for arguments
    while getopts ":bh" options; do
        case "${options}" in
            b)
                brewit=1;
                ;;
            h|*) # Display usage.
                usage
                return 1;
                ;;
        esac
    done

    echo -e "Good morning, ${IYellow}${nameuser}${Color_Off}."

    if [ $brewit -eq 1 ]
    then
        echo -e "\n${ICyan}Updating Homebrew...${Color_Off}"
        brew update && brew upgrade
    fi

    echo -e "\n${ICyan}The weather right now${Color_Off}:"
    #sweather
    curl wttr.in/01830

    getnews -t "$news_1"

    getnews -r  

    getnews -t "$news_2"
}

# Open all likely work applications.
startwork()
(
    open -a Microsoft\ Teams
    open -a Microsoft\ Outlook
    open -a Firefox
    open -a Evernote
    open -a flowdock

)

# Setting remind function. 
# Lets you set reminders to display whenever you open a new terminal. 
# Everything in ~/.reminder will be displayed. Everything in ~/.reminder-oneshot will 
# be displayed and then the file will be erased. 
# Use remind whatever to add a new line to ~/.reminder, or remind with no arguments to 
# run it interactively and add multiple lines. Use unremind to remove the last line from 
# ~/.reminder (this requires moreutils to be installed).
rem_file=$HOME/.reminder
if [ -s $rem_file ]; then
    echo -e "${BBlue}Today's${Color_Off} reminders are:"
    cat $rem_file
fi

if [ -f ${rem-file}-oneshot ]; then
    cat ${rem_file}-oneshot
    rm ${rem_file}-oneshot
fi

remind()
{
    if [ "$1" ]; then
        echo "$@" >> ~/.reminder
    else
        cat >> ~/.reminder
    fi
}

unremind()
{
    if [ -s ${rem_file} ]
    then
        cp ${rem_file} ${rem_file}.swp
        sed '$ d' ${rem_file}.swp > ${rem_file}
        rm -f ${rem_file}.swp
    else
        echo -e "${Yellow}You have no reminders set.${Color_Off}"
    fi
}

# Search through https://www.commandlinefu.com
cmdfu()
{
    curl -L "http://www.commandlinefu.com/commands/matching/$(echo "$@" \
    | sed 's/ /-/g')/$(echo -n $@ | base64)/plaintext"
}

# Alarm function. WIP 
alarm() 
{
    (($# < 2)) && {
        echo "usage: alarm <seconds> <msg>"
        return 1
        }
    local wait=$1 ; shift                                                                                                              
    (sleep $wait 2>/dev/null && echo -e "\n!!\n$*\n!!\n" &)                   
}

# Openstack Funtions
uosp()
{
    # Unset Openstack variables and resets command prompt.
    unset OS_REGION 
    unset OS_USERNAME
    unset OS_TENANT_NAME
    unset OS_PASSWORD
    unset OS_AUTH_URL
    unset OS_REGION_NAME
    unset OS_IDENTITY_API_VERSION

    #PS1='[\[\e[32m\]\u\[\e[m\].\[\e[35m\]\h\[\e[m\] \W] ➤ '
}

