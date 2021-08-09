brew_home="/opt/homebrew"
export PATH="${brew_home}/opt/llvm/bin:$PATH"
export PATH="${brew_home}/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I${brew_home}/opt/openjdk/include"
export FPATH="${brew_home}/share/zsh/site-functions:$FPATH"
unset brew_home
