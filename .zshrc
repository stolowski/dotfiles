# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=6000
SAVEHIST=6000
DIRSTACKSIZE=16
setopt autocd extendedglob autopushd pushd_ignore_dups auto_menu auto_list prompt_subst hist_ignore_all_dups
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/home/pawel/.zshrc'

autoload zutil
autoload complist
autoload -Uz compinit
autoload zmv
compinit -C
# End of lines added by compinstall
zstyle ':completion:*' menu select=5

setopt inc_append_history
setopt share_history

alias -g M="| most"
alias d="dirs -v"
alias CC="[ -f CMakeCache.txt ] && rm -rf **/CMakeFiles **/CMakeCache.txt **/Makefile"
alias ii="sudo apt-get install"
alias q="dpkg -l|grep"
alias qq="apt-cache show"
alias u="cd ~/src/ubuntu"

# bzr aliases
alias bl="bzr log -l1"
alias bll="bzr log -l5"
alias bq="bzr qlog"
alias bd="bzr qdiff"
alias m="make"
alias m2="make -j2"
alias m3="make -j3"

# lxc aliases
alias lxc-ips="awk '{print \$3, \$4}' /var/lib/misc/dnsmasq.leases"

#autoload -Uz vcs_info

autoload -U colors && colors

################## PROMPT #########################
if [ -e /etc/debian_chroot ]; then
    NAME=$fg[red]$(cat /etc/debian_chroot)
elif grep -q "# UNCONFIGURED" /etc/fstab; then   ### this is the case for lxc containers
    NAME="%F{yellow}%m"
else
    NAME="%m"
fi
#PS1="%B$NAME:%{$fg[green]%}%d%%%{$reset_color%}%b "
PS1="%B$NAME:%F{green}%d%%%{$reset_color%}%b%F{white} "

################## TERMINAL TITLE #################
set_title() { printf "\e]0;$@\a" }
dir_in_title() { set_title $PWD }
chpwd_functions=(dir_in_title)

#autoload -U promptinit
#promptinit
#prompt adam2

export DEBFULLNAME="Pawel Stolowski"
export DEBEMAIL="pawel.stolowski@ubuntu.com"
export QUILT_PATCHES=debian/patches
export EDITOR=vim
alias e="$EDITOR"

export SSH_ASKPASS=/usr/lib/openssh/gnome-ssh-askpass

ANDROID_SDK=$HOME/Android/android-sdk-linux

export PATH=/usr/lib/ccache:$PATH
PATH=$PATH:$HOME/bin:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
