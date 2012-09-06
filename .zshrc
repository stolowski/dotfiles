# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=6000
SAVEHIST=6000
setopt autocd extendedglob autopushd pushd_ignore_dups auto_menu auto_list prompt_subst hist_ignore_all_dups
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/home/pawel/.zshrc'

autoload zutil
autoload complist
autoload -Uz compinit
compinit -C
# End of lines added by compinstall

setopt inc_append_history
setopt share_history

alias -g M="| most"
alias D="dirs -v"
alias CC="[ -f CMakeCache.txt ] && rm -rf **/CMakeFiles **/CMakeCache.txt **/Makefile"
alias II="sudo apt-get install"
alias QQ="dpkg -l|grep"
alias QQQ="apt-cache show"

#autoload -Uz vcs_info

autoload -U colors && colors
[ -e /etc/debian_chroot ] && CHROOT=$fg[red]$(cat /etc/debian_chroot):
PS1="%B%m:%{$CHROOT%}%{$fg[green]%}%d%%%{$reset_color%}%b "

#autoload -U promptinit
#promptinit
#prompt adam2

export DEBFULLNAME="Pawel Stolowski"
export DEBEMAIL="pawel.stolowski@ubuntu.com"
export QUILT_PATCHES=debian/patches
export EDITOR=emacsclient

export SSH_ASKPASS=/usr/lib/openssh/gnome-ssh-askpass

export PATH=/usr/lib/ccache:$PATH
