# 言語
export LANG=ja_JP.UTF-8

# PATH
PATH=$HOME/dotfiles/bin_share:$PATH

# LS時の色を変更

# Color Settings
autoload -U colors
colors
case "${TERM}" in
xterm)
    export TERM=xterm-color

    ;;
kterm)
    export TERM=kterm-color
    # set BackSpace control character

    stty erase
    ;;

cons25)
    unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad

    export LS_COLORS='di=01;32:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30'
    zstyle ':completion:*' list-colors \
        'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;

kterm*|xterm*)
   # Terminal.app
#    precmd() {
#        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
#    }
    # export LSCOLORS=exfxcxdxbxegedabagacad
    # export LSCOLORS=gxfxcxdxbxegedabagacad
    # export LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30'

    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    alias gls="gls --color"
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;

dumb)
    echo "Welcome Emacs Shell"
    ;;
esac

# screen SSH settings
# SSH接続時に新しいウインドウにする
# 何か複窓だと挙動おかしい。
#if [[ $TERM == "xterm-256color" ]]; then
#   function ssh_tmux() {
#     eval server=\${$#}
#     eval tmux new-window -n "'${server}'" "'ssh $@'"
#   }
#   alias ssh=ssh_tmux
#fi

# プロンプト
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local WATER=$'%{\e[1;36m%}'
local DEFAULT=$'%{\e[1;m%}'
prompt_host="$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]')"  # Current host name
prompt_date="%D{%H:%M:%S}"   # Datetime YYYY/mm/dd HH:MM
#PROMPT=$'\n'$BLUE'${USER}@${HOSTNAME} '$WATER'%~ '$'\n'$DEFAULT'%(!.#.$) '
#PROMPT=$'\n'$BLUE'[${USER}@${prompt_host}] '"%B%{${BLUE}%}%(5~.%-2~/%{${WATER}%}(ry%{${BLUE}%}/%2~.%~)%(!.#.$) %{${YELLOW}%}[input time:${prompt_date}]%{${BLUE}%}%"' '$'\n'$DEFAULT'%(!.#.$) '
PROMPT=$'\n'$BLUE'[${USER}@${prompt_host}]'"%{%(?.$fg[cyan].$fg[red])%}%(?.(▰╹◡╹%).ヾ(｡>﹏<｡%)ﾉﾞ)%B%{${BLUE}%}%(5~.%-2~/%{${WATER}%}(ry%{${BLUE}%}/%2~.%~)%(!.#.$) %{${YELLOW}%}[input time:${prompt_date}]%{${BLUE}%}%"' '$'\n'$DEFAULT'%(!.#.$) '
setopt PROMPT_SUBST

# 右プロンプトはvcs関連を表示
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{"$WATER"%1v%f|)"

# ターミナルのタイトル
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac



# emacsライクなキーバインド
bindkey -e

# 補完検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# rakeコマンドはやけに重たいので補完対象から除外
compdef -d rake

# autojump settings
if [[ -f ~/.autojump/etc/profile.d/autojump.zsh ]]; then
  source ~/.autojump/etc/profile.d/autojump.zsh
fi

# 自動cd
setopt auto_cd

# cd後にls
function chpwd() { ls -vFG }

# cd -<TAB>で、過去のディレクトリ
setopt auto_pushd
setopt pushd_ignore_dups

# コマンドもしかして
setopt correct

# リストを詰めて表示
setopt list_packed

# リストでビープを鳴らさない
setopt nolistbeep

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 'google ほげほげ'ですぐに検索。
function google() {
local str opt
if [ $ != 0 ]; then
	for i in $*; do
		str="$str+$i"
	done
	str=`echo $str | sed 's/^\+//'`
	opt='search?num=50&hl=ja&lr=lang_ja'
	opt="${opt}&q=${str}"
fi
w3m http://www.google.co.jp/$opt
}

# w3mでALC検索
function alc() {
if [ $ != 0 ]; then
	w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
else
	w3m "http://www.alc.co.jp/"
fi
}

setopt IGNOREEOF

# 補完機能
autoload -U compinit
compinit

case "$TERM" in
screen)
	preexec() {
		echo -ne "\ek#${1%% *}\e\\"
	}
	precmd() {
		echo -ne "\ek$(basename $(pwd))\e\\"
	}
esac

# コマンド補完
HISTFILE=~/.zsh_history
HISTSIZE=10000000000
SAVEHIST=10000000000
setopt hist_ignore_dups
setopt share_history
setopt hist_save_no_dups

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

## auto-fu.zsh stuff.
# source ~/auto-fu.zsh/auto-fu.zsh
{ . ~/.zsh/auto-fu; auto-fu-install; }
zstyle ':completion:*' completer _oldlist _complete
zstyle ':auto-fu:highlight' input bold
zstyle ':auto-fu:highlight' completion fg=black,bold
zstyle ':auto-fu:highlight' completion/one fg=white,bold,underline
zstyle ':auto-fu:var' postdisplay $'\n-azfu-'
zle-line-init () {auto-fu-init;}; zle -N zle-line-init

# alias
alias ls="ls -vFG"
alias ll="ls -vlFG"
alias la="ls -vaFG"
alias diff="colordiff"
alias grep="grep --color"
alias rm="rm -i"
# alias less="/usr/share/vim/vim72/macros/less.sh"

# global alias
alias -g L="|less -R"
alias -g P='|pbcopy'
alias -g G='|grep'
alias -g V='|vim -R -'

# svn_alias
alias svnci="svn commit -m"
alias svndiff="svn diff L"
alias svnlog="svn log --verbose L"
alias svnup="svn up"

# app_alias
alias vim="/usr/local/bin/vim"
alias php="/usr/local/bin/php"
#alias coffee="coffee@1.0.1"


#RVM params
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

#if MacVim Installed Launch from MacVim
#if [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
#  alias vim='/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab 2>/dev/null >/dev/null'
#  export EDITOR='/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-wait'
  export EDITOR=vim
#fi
eval "$(rbenv init -)";
