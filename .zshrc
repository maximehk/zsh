# ZSHELL config file

autoload -Uz promptinit
promptinit
prompt adam1

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


# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu yes  # always display the menu
zstyle ':completion:*' menu select=10  # activate selection if more than 10 items
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

mkdir -p $HOME/.zsh/cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache

for ext in 'sh' 'inc' 'zsh' ; do
  for file in $(find $HOME/.profile.d -name "*.${ext}" -type f) ; do . $file ; done
done

if [[ ! $TERM =~ screen ]]; then
   exec tmux
fi

