port_prefix="/opt/local"
export PATH="$port_prefix/bin:$PATH"
export PATH="$port_prefix/sbin:$PATH"
export MANPATH="$port_prefix/share/man:$MANPATH"
export OPENSSL_ROOT_DIR="$port_prefix"
# Java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/default/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"
# Go
export GO111MODULE=on
export GOPROXY=https://proxy.golang.com.cn,direct
export GOSUMDB=sum.golang.google.cn
unset port_prefix
