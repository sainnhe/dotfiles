port_prefix="/opt/local"
export PATH="$port_prefix/bin:$PATH"
export PATH="$port_prefix/sbin:$PATH"
export MANPATH="$port_prefix/share/man:$MANPATH"
export OPENSSL_ROOT_DIR="$port_prefix"
fpath=($port_prefix/share/zsh/site-functions $fpath)
unset port_prefix
