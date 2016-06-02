# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/thehermit/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' menu select

zstyle ':completion*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion*:cd:*' ignored-patterns '(*/)#CVS'

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match' original-only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' \
	max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:xdvi:*' menu yes select
zstyle ':completion:*:*:xdvi:*' file-sort time
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:cd:*' ignore-parents parent pwd

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

setopt correct_all

# Correctly set keybindings (Home, End, PgUp, PgDn...) with terminfo
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
if [[ ! -o login ]];
then
	typeset -A key
	
	key[Home]=${terminfo[khome]}
	key[End]=${terminfo[kend]}
	key[Insert]=${terminfo[kich1]}
	key[Delete]=${terminfo[kdch1]}
	key[Up]=${terminfo[kcuu1]}
	key[Down]=${terminfo[kcud1]}
	key[Left]=${terminfo[kcub1]}
	key[Right]=${terminfo[kcuf1]}
	key[PageUp]=${terminfo[kpp]}
	key[PageDown]=${terminfo[knp]}
	
	# setup key accordingly
	[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
	[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
	[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
	[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
	[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
	[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
	[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
	[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
	
	# Finally, make sure the terminal is in application mode, when zle is
	# active. Only then are the values from $terminfo valid.
	function zle-line-init () {
	    echoti smkx
	}
	function zle-line-finish () {
	    echoti rmkx
	}
	zle -N zle-line-init
	zle -N zle-line-finish  
fi
# Prompt
autoload -Uz colors && colors

NEWLINE=$'\n'

PROMPT="%{%F{yellow}« %~ »%f%}${NEWLINE}%{%B%F{blue}%}> %{%f%b%}"

# Syntax Highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# PATH
PATH=$PATH:/home/pouncelciot/bin

# Aliases
alias steam-wine='WINEDEBUG=-all wine ~/.local/share/wineprefixes/steam/drive_c/Program\ Files\ \(x86\)/Steam/Steam.exe &>/dev/null &'
alias ls='ls --color=auto'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -v'
alias grep='grep --color=auto'
alias byond='WINEARCH=win32 WINEPREFIX=$HOME/.local/share/wineprefixes/byond WINEDEBUG=-all wine "C:/Program Files/Byond/bin/byond.exe"'

# Temporary reminder (until I memorize it)
#echo "Press M-b and M-f to jump words (respectively backwards and forwards) disable on .zshrc when I memorize this"
