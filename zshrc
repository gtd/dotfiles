# ----------------------------------------------------------------------
# GENERAL ZSH CONFIG
# ----------------------------------------------------------------------
setopt autocd
cdpath=(~/xplr ~/work)

# Vi bindings http://www.cs.elte.hu/zsh-manual/zsh_14.html
#bindkey -v
#bindkey ^r history-incremental-search-backward
bindkey ^f forward-word
bindkey ^b backward-word

# Inspired by, and borrowing from https://github.com/rtomayko/dotfiles
: ${HOME=~}
: ${LOGNAME=$(id -un)}
: ${UNAME=$(uname)}
#: ${EDITOR=vim}
# The above did not work for eb config, why?
export EDITOR=vim


# ----------------------------------------------------------------------
# PATH
# ----------------------------------------------------------------------

# Usage: puniq [<path>]
# Remove duplicate entries from a PATH style value while retaining
# the original order. Use PATH if no <path> is given.
#
# Example:
#   $ puniq /usr/bin:/usr/local/bin:/usr/bin
#   /usr/bin:/usr/local/bin
puniq () {
    echo "$1" |tr : '\n' |nl |sort -u -k 2,2 |sort -n |
    cut -f 2- |tr '\n' : |sed -e 's/:$//' -e 's/^://'
}

PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"
PATH="/usr/local/bin:$PATH"
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"
PATH="$HOME/.rbenv/bin:$PATH"
# This also must be added after rbenv init in .zshrc
PATH=$HOME/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/bin:$PATH
# Add homebrew python3 defaults
PATH=/usr/local/opt/python/libexec/bin:$PATH

# Set up homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

PATH=$(puniq $PATH)


# ----------------------------------------------------------------------
# ENVIRONMENT CONFIGURATION
# ----------------------------------------------------------------------

# detect interactive shell
case "$-" in
    *i*) INTERACTIVE=yes ;;
    *)   unset INTERACTIVE ;;
esac

# detect login shell
case "$0" in
    -*) LOGIN=yes ;;
    *)  unset LOGIN ;;
esac

# enable en_US locale w/ utf-8 encodings if not already configured
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL


# ----------------------------------------------------------------------
# TIME MACHINE
# ----------------------------------------------------------------------
alias tmdiff='cd /Volumes/Time\ Machine\ Backups/Backups.backupdb/g-abbatoir && timedog -d 7 -m 100k -ls'


# ----------------------------------------------------------------------
# GIT
# ----------------------------------------------------------------------
alias git='nocorrect git'

function gitkbr {
  gitk $1 --not $(git show-ref --heads | cut -d' ' -f2 | grep -v "^refs/heads/$1")
}

function gitkta {
  gitk $1 --not refs/heads/master
}

function st {
  open ${1-.} -a SourceTree
}


# ----------------------------------------------------------------------
# RUBY
# ----------------------------------------------------------------------
alias bx='bundle exec'
alias r='bundle exec rails'
alias rk='bundle exec rake'

: ${GEM_EDITOR=mvim} # For gem-open gem which must be installed
# Fix gem builds, eg. http://stackoverflow.com/questions/26457083/gem-install-mysql2-v-0-3-11-not-working-on-yosemite
: ${MACOSX_DEPLOYMENT_TARGET=10.9}


# ----------------------------------------------------------------------
# RAILS
# ----------------------------------------------------------------------
function rsv {
  if [ -e .rails_dev ]; then
    port=$(ruby -ryaml -e 'puts YAML.load_file(".rails_dev")["port"]')
  else
    port=3000
  fi

  if bundle exec rails -v | egrep -q '2.[0-9]+.[0-9]+'; then
    script/server -u -p$port
  elif gem list | grep -q mongrel; then
    script/rails server -u -p$port
  else
    bx thin start -p $port
  fi
}

function rt {
  if [ $# -le 1 ] ; then
    echo Running: ruby -Itest $1
    ruby -Itest $1
  else
    p2=$2
    param=$p2[0,5]
    if [ $param = 'test/' ] ; then # Assumes all test files are in test/**
      while [ "$1" != "" ]; do
        if [ ! $test_files ]; then
          local test_files=$1
        else
          test_files="$test_files,$1"
        fi
        shift
      done
      echo Running: rake TEST_FILES=$test_files # Note this requires custom Rakefile http://stackoverflow.com/questions/6656935/how-to-run-multiple-rails-unit-tests-at-once
      rake TEST_FILES=$test_files
    else
      regex=/$argv[2,-1]/
      echo "Running: ruby -Itest $1 '$regex'"
      ruby -Itest $1 -n $regex
    fi
  fi
}

function brt {
  while [ "$1" != "" ]; do
    if [ ! $test_files ]; then
      local test_files=$1
    else
      test_files="$test_files,$1"
    fi
    shift
  done
  echo Running: bin/rake TEST_FILES=$test_files
  bin/rake TEST_FILES=$test_files
}


# ----------------------------------------------------------------------
# CODE HIGHLIGHTING
# ----------------------------------------------------------------------
function hl {
  if (( $# != 1 ))
  then
    echo usage: hl name;
  else
    highlight -O rtf $1 --line-numbers --font-size 24 --font Inconsolata --style solarized-dark | pbcopy
  fi
}


# ----------------------------------------------------------------------
# RBENV
# ----------------------------------------------------------------------
eval "$(rbenv init -)"


# ----------------------------------------------------------------------
# CHEF-DK
# ----------------------------------------------------------------------
# This needs to be after rbenv paths
PATH=$HOME/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/bin:$PATH


# ----------------------------------------------------------------------
# PERL
# ----------------------------------------------------------------------
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
PERL5LIB=$HOME/perl5/lib/perl5:$PERL5LIB; export PERL5LIB;


# ----------------------------------------------------------------------
# BUSBK
# ----------------------------------------------------------------------
alias bb='cd ~/work/busbk'


# ----------------------------------------------------------------------
# MASKMAIL
# ----------------------------------------------------------------------
alias mm='cd ~/work/maskmail'


# ----------------------------------------------------------------------
# MISC
# ----------------------------------------------------------------------
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f /Users/gtd/.travis/travis.sh ] && source /Users/gtd/.travis/travis.sh

# NVM
#export NVM_DIR=~/.nvm
#source $(brew --prefix nvm)/nvm.sh

# iTerm2 Shell Integration https://iterm2.com/shell_integration.html
source ~/.iterm2_shell_integration.`basename $SHELL`

# Add local extensions in .zshrc_local/
for file in .zshrc_local/*.zsh(.N); do
  source $file
done

# AWS CLI Autocompletion
if [ -f '/usr/local/bin/aws_zsh_completer.sh' ]; then source '/usr/local/bin/aws_zsh_completer.sh'; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/gtd/work/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/gtd/work/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/gtd/work/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/gtd/work/google-cloud-sdk/completion.zsh.inc'; fi
