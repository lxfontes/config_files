if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

## direnv.net
eval "$(direnv hook zsh)"

## jump
eval "$(jump shell zsh)"

## rubby
eval "$(rbenv init - --no-rehash)"


iterm_badge() {
 printf "\e]1337;SetBadgeFormat=%s\a" \
  $(echo -n "$@" | base64)
}

# Homebrew will not send analytics
export HOMEBREW_NO_ANALYTICS=1
# Homebrew will not auto-update before running `brew install`, `brew upgrade` or `brew tap`.
export HOMEBREW_NO_AUTO_UPDATE=1
alias flushdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say cache flushed"

export PATH=$HOME/bin:/usr/local/bin:/usr/local/opt/python/libexec/bin:/usr/local/sbin:$PATH

alias bi='bundle install'
alias be='bundle exec'

export GOPATH=$HOME/code
export PATH=$PATH:$GOPATH/bin

alias vi=nvim
alias vim=nvim
export EDITOR=nvim
export VISUAL=nvim

alias k=kubectl
alias g=git

alias hazip="dig +short myip.opendns.com @resolver1.opendns.com"
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
alias dev_layout='tmux split-window -h -p 40 && tmux split-window -v'

bindkey "^r" history-incremental-search-backward
export KEYTIMEOUT=1

if [ -f ${ZDOTDIR:-$HOME}/.zshrc.local ]; then
  source ${ZDOTDIR:-$HOME}/.zshrc.local
fi
