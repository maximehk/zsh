# Folder with custom binaries / commands

_local_bin="$HOME/.local/bin"
mkdir -p ${_local_bin}
export PATH="${_local_bin}:$PATH"

path_remove_matching() {
  pattern="$1"
  export PATH="$(echo $PATH | perl -lne 'BEGIN{$/=":" ; $\=":"; $pattern=shift} ; if (!/$pattern/ and $c{$_}++==0) {print}' -- $pattern)"
}

noconda() { path_remove_matching "anaconda" }

path_show() {
  echo "$PATH" | tr ':' '\n'
}


# GOLANG
if [[ -d "$HOME/.local/go/bin" && -d "$HOME/go" ]] ; then
  export GOROOT="$HOME/.local/go"
  export PATH="$PATH:$GOROOT/bin"
  export GOPATH="$HOME/go"
fi
