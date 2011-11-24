# 言語
export LANG=ja_JP.UTF-8

# プロンプト
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local DEFAULT=$'%{\e[1;m%}'
PROMPT=$'\n'$GREEN'${USER}@${HOSTNAME} '$YELLOW'%~ '$'\n'$DEFAULT'%(!.#.$) '
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
RPROMPT="%1(v|%F{green}%1v%f|)"

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
# alias vim="/opt/local/bin/vim"
alias coffee="coffee@1.0.1"


#RVM params
 [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

#if MacVim Installed Launch from MacVim
if [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
  alias vim='/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-tab 2>/dev/null >/dev/null'
  export EDITOR='/Applications/MacVim.app/Contents/MacOS/Vim -g --remote-wait'
#  export EDITOR=vim
fi

