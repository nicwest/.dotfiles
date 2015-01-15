# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias notify="osascript -e 'display notification \"Done\" with title \"Done\"'"
alias dev="git checkout develop"
alias mas="git checkout master"
alias g-="git checkout -"
alias v="vim"
alias gmf='git merge --no-ff'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git autojump tmux history-substring-search gitignore osx web-search)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/Users/nic/local/bin:/Users/nic/bin:/usr/local/bin:$PATH"
export LANG=en_GB.UTF-8
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
if [ `uname` = "Darwin" ]; then
    export EDITOR=/usr/local/bin/vim
else
    export EDITOR=vim
fi


#DISABLE SCROLL LOCK (http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator)
stty -ixon

# ctrl-z toggle:
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
    zle redisplay
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

get_suspended_jobs() {
  # thanks to @mheap for his help
  NUM_JOBS="`jobs | wc -l`"
  if test $NUM_JOBS -lt 1 ; then
    echo ""
  else
    echo "("`jobs | gsed -r 's/ .*suspended (\(signal\))?//' | tr -s ' ' | gsed 's/\[\([^]]*\)\]/\1:/g' | gsed 's/\: /\:/g'`")"
  fi
}

RPROMPT='%{$fg['blue']%} $(get_suspended_jobs)%{$reset_color%}'
THEMIS_HOME='/Users/nic/.vim/bundle/vim-themis/'

source ~/perl5/perlbrew/etc/bashrc
