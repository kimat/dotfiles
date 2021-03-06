# vim: set fdm=marker:
# {{{ mixed
alias ranger='ranger --cmd "set preview_files True"'
alias spot="spot -e log -e public -e lib/assets"
alias spott="spot"
alias nocolors="perl -pe 's/\e\[?.*?[\@-~]//g'"
alias json="jq '.'"
function cd {
  builtin cd "$@" && ls
}
# be rake db:drop ; be rake db:setup ; be rake
alias cucumber="be cucumber --require features" # --format progress"
alias cu="cucumber"
alias appservers='ssh app@"$(~/mdp/dps-tools/bin/appservers | nocolors | peco)"'
alias setupdeploy="~/mdp/dps-tools/bin/setup_deploy.sh"
alias vpn="(cd ~/vcloud-vpn/Y ; sudo openvpn vcloud.ovpn)"
alias clip="xclip -selection c" #use system clipboard instead of the x clipboard (middleclick)
alias ack="ack-grep"
alias docker="sudo docker"
alias eb="exec bash"
alias otp="ruby ~/otp.rb | xclip"
alias ootp="ruby ~/otp.rb"
# }}}
# Keyboard Related {{{
alias a='bel ;  xmodmap ~/.xmodmap ; (cd ~ ; sh a.sh)'
alias aa='bel ;  xmodmap ~/.xmodmap ; xmodmap ; sh a.sh'
alias bel='setxkbmap be -option ctrl:nocaps'
alias beep='paplay /usr/share/sounds/gnome/default/alerts/drip.ogg'
alias eb='exec bash'
alias xb='xev | grep -A2 --line-buffered '\''^KeyRelease'\'' | sed -n '\''/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'\'''
alias xd='pkill xcape; xcape -d'
alias xm='xev | grep button'
alias xx='xbindkeys -k'
# }}}
# BOWER {{{
alias bower="bower --allow-root"
# }}}
# LINUX {{{
alias wget="wget --continue "
alias log="less +F +G "
alias e="fc"
alias server="echo python -m SimpleHTTPServer"
# }}}
# SSH {{{
select_a_known_ssh_server() {
  echo `egrep '^Host\s(.*)$' ~/.ssh/config | awk '{print $2}' | peco`
}
s() {
  if [ $# -eq 0 ]; then
    A=$(select_a_known_ssh_server)
  else
    A=$1
      fi
      tmux_rename_window $A
      ssh "$A"
}
alias s=s
# }}}
# TMUX {{{
tmux_rename_window() {
  B=`tmux display-message -p '#W'`
  if [ "$B" == "bash" ]; then
    tmux rename-window "$1-prod"
  fi
}
alias t="tmux -u attach || ~/dotfiles/bin/tmuxifier s main"
alias tl="tmuxifier-list-windows"
to() {
  tmuxifier-load-window $(tl | percol)
}
alias to=to
# }}}
# UBUNTU {{{
alias lso="ls -alG | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'" # octal ls
alias apts="sudo apt-cache search"
alias apti="sudo apt-get install -y"  #--no-install-recommends"
alias aptv="sudo apt-cache madison"
alias aptI="sudo apt-cache madison"
alias aptu="sudo apt-get update"
alias aptr="sudo apt-get --purge autoremove"
alias aptU="sudo apt-get install --only-upgrade"
# }}}
# TYPOS {{{
alias sl="ls"
# }}}
# VIM {{{
alias ":e"="nvim"
alias rmswp='find -name "*.swp" -delete'
vv() {
  \vim -c ":CtrlSpaceLoadWorkspace $1"
}
v() {
  vim -c ":CtrlSpaceLoadWorkspace $1"
}
alias vd='v ~/dotfiles dotfiles'
alias vm='v /vagrant md'
alias vt='vim ~/.tmux.conf /vagrant/writing-using/tmux.md ~/.tmuxifier/layouts/main.session.sh'
alias vbt='vim ~/.bash_aliases ~/.bashrc /vagrant/writing-using/unix/unix_bash.md \
  ~/.tmux.conf /vagrant/writing-using/tmux.md ~/.tmuxifier/layouts/main.session.sh'
alias vb='vim ~/.bash_aliases ~/.bashrc /vagrant/writing-using/unix/unix_bash.md'
alias ve='(cd /vagrant/ecam ; vim done.md projects.md ecam.md'
# }}}
# RUBY ALIASES {{{
alias be="bundle exec"
alias bec="be rails c"
alias bes="be rails s"
alias besb="be rails s -b0.0.0.0"
alias ber="be rspec"
alias beR="be rake parallel:spec"
alias rspec="ber"
alias "f"="foreman start -f Procfile.dev -e /dev/null"
alias "rs"="rails server -b0.0.0.0"
alias "rc"="rails console"
# alias "foreman"="foreman -e /dev/null "
alias "fd"="foreman start -f Procfile.dev -e /dev/null"
alias "re"="echo $RAILS_ENV"
alias bu='bundle update'
alias bi='bundle install'
alias bui='bundle update -j4 ;  bundle install -j4'
# alias buip='bundle update -j4 ;  bundle install -j4 --without development'
# }}}
# GIT ALIASES {{{
alias gc-='git checkout -'
alias gc.='git checkout .'
alias gco='git checkout "$(git branch | sed 's/^..//' | peco)"'
alias gcom='git checkout master && gf'
function gcoo() {
  local selected="$(git branch -a  | sed 's/remotes\/origin\///' | sed 's/^..//' | peco)"
  git checkout $selected
}
alias gst="git stash --keep-index"
alias gstn="git stash save --keep-index"
alias gstp="git stash pop"
# git config user.email k.boven@ecam.be
# git config user.name BOVEN Kimat
alias gd="tmux resize-pane -Z ; git-icdiff --cached ; tmux resize-pane -Z"
alias gdd="tmux resize-pane -Z ; git-icdiff ; tmux resize-pane -Z"
alias gz="git reset HEAD"
alias gph="git push && git push heroku master"
alias g="git"
# alias gdd="git --no-pager diff"
# alias gd="git --no-pager diff --cached"
alias ga="git add "
alias gal="git add --all"
# alias gs="watch -t -n 1 --color git status --short"
alias pwdd="pwd | sed 's/\//_/g'"
alias gs="while true; do clear; git-radar --fetch --bash > /tmp/$(pwdd) ; echo "" >> /tmp/$(pwdd) ; git status >> /tmp/$(pwdd); cat /tmp/$(pwdd) ;sleep 4;  done"
# alias gs="while true; do clear; git-radar --fetch --bash > /tmp/$(pwdd) ; echo "" >> /tmp/$(pwdd) ; git status --short >> /tmp/$(pwdd); cat /tmp/$(pwdd) ;sleep 2;  done"
alias gm="git commit"
# gc() {
#   git commit -m "$*"
# }
# alias gc=gc
alias gc="git commit"
alias gf="git pull --rebase"
alias gp="git push"
alias gl="git --no-pager log --graph --abbrev-commit --decorate --format=format:\
'%C(bold blue)%h%C(reset)'\
' - '\
'%C(white)%s%C(reset)'\
 --all\
 | head -n 10"
# '%C(bold cyan)%ar %C(reset)'\
# '%C(bold yellow)%d%C(reset)'\
# '%C(dim white)- %an%C(reset)'\
# @Slipp D. Thompson : [Pretty git branch graphs - Stack Overflow](http://stackoverflow.com/questions/1057564/pretty-git-branch-graphs)

alias gll="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(dim white)(%ar)%C(reset) %C(white)%s%C(reset)' --all"
alias glll="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
# }}}
# FZZ ? {{{
fh() {
  eval $(history)
}
bind '"\C-F:"fh\n"'
# }}}
