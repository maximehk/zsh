#!/bin/bash

# some more ls aliases
alias ll='ls -lF --color=auto'
alias l='ls -lFrt --color=auto'
alias la='ls -A'

alias grep="grep --color"
alias ..="cd .."

# Display time in a different timezone
function syd  { TZ="Australia/Sydney" date $@ +'%F %T %Z' ; }
function tok  { TZ="Asia/Tokyo" date $@ +'%F %T %Z' ; }
function pdt  { TZ="America/Los_Angeles" date $@ +'%F %T %Z' ; }
function pst  { TZ="America/Los_Angeles" date $@ +'%F %T %Z' ; }
function nyt  { TZ="America/New_York" date $@ +'%F %T %Z' ; }
function edt  { TZ="America/New_York" date $@ +'%F %T %Z' ; }
function d  { TZ="Europe/Paris" date $@ +'%F %T %Z' ; }
function epoch { date $@ +'%s' ; }

# Misc
alias xclip="xclip -selection c"  # copy stdin to clipboard

# Alias SublimeText with `s` if it is in the path
sublime_path=$(which subl) 2> /dev/null && alias s="${sublime_path}"

function sony {
  local device_id="CC:98:8B:57:27:2D"

  if [[ "$1" == "connect" ]] ; then
    echo "connect ${device_id}" | bluetoothctl 2>/dev/null 1>&2 ; 
  elif [[ "$1" == "disconnect" ]] ; then
    echo "disconnect ${device_id}" | bluetoothctl 2>/dev/null 1>&2 ; 
  fi
}

br() { xrandr 2> /dev/null | perl -lane 'if (/(\S+) connected/) {print $1}' | xargs -I@ xrandr --output @ --brightness $1 }

