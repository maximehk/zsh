# ZSHELL config file

local zshrc_start="$(date +'%s.%N')"

perf_log="$HOME/.profile_perf.log"

_init_prompt() {
  autoload -Uz promptinit
  promptinit

  local host="$(hostname -f | cut -d'.' -f1,2)"
  prompt="%K{blue}%n@${host}%k %B%F{cyan}%(4~|...|)%3~%F{white} %# %b%f%k"
}

_init_prompt

# prompt adam1

export EDITOR="vi"

setopt AUTO_CD  # type `dir` instead of `cd dir`
setopt MULTIOS  # pipe to multiple outputs
setopt NO_BEEP
setopt NO_CASE_GLOB  # Case insensitive globbing
setopt NUMERIC_GLOB_SORT
setopt RM_STAR_WAIT  # 10 second wait if you do something that will delete everything

# History config
export HISTFILE=~/.history
export HISTSIZE=90000
export SAVEHIST=$HISTSIZE
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS


local end="$(date +'%s.%N')"
let duration=$end-$zshrc_start
echo "$$,$HOME/zshrc_setopts,$duration" >> "$perf_log"

# Use modern completion system
autoload -Uz compinit
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
compinit

local end="$(date +'%s.%N')"
let duration=$end-$zshrc_start
echo "$$,$HOME/zshrc_compinit,$duration" >> "$perf_log"


bindkey -e  # emacs key bindings
setopt menucomplete

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

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
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char "$terminfo[kcuu1]" up-line-or-beginning-search


local end="$(date +'%s.%N')"
let duration=$end-$zshrc_start
echo "$$,$HOME/zshrc_keys,$duration" >> "$perf_log"


# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
function zle-line-init () {
  if (( ${+terminfo[smkx]} )); then
    echoti smkx
  fi
}
function zle-line-finish () {
  if (( ${+terminfo[rmkx]} )); then
    echoti rmkx
  fi
}
zle -N zle-line-init
zle -N zle-line-finish  


local end="$(date +'%s.%N')"
let duration=$end-$zshrc_start
echo "$$,$HOME/zshrc_zle,$duration" >> "$perf_log"


zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu yes  # always display the menu
zstyle ':completion:*' menu select=6  # activate selection if more than 6 items
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

mkdir -p $HOME/.zsh/cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache


local end="$(date +'%s.%N')"
let duration=$end-$zshrc_start
echo "$$,$HOME/zshrc_ztyle,$duration" >> "$perf_log"

for ext in 'sh' 'inc' 'zsh' ; do
  for file in $(find $HOME/.profile.d -name "*.${ext}" -type f) ; do
    # t="$(date +'%H:%M:%S.%N')"
    # echo "${t}: $file"
    local start="$(date +'%s.%N')"
    . $file
    end="$(date +'%s.%N')"
    let duration=$end-$start
    echo "$$,$file,$duration" >> "$perf_log"
  done
done

#if [[ ! $TERM =~ screen ]]; then
#   exec tmux
#fi

local end="$(date +'%s.%N')"
let duration=$end-$zshrc_start
echo "$$,$HOME/zshrc_end,$duration" >> "$perf_log"

export HISTIGNORE='rm *:svn revert*'

