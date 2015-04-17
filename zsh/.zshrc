# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="kolo"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
TODO_SH="/home/nic/things/todo.txt_cli-2.9/todo.sh"
#alias notify="osascript -e 'display notification \"Done\" with title \"Done\"'"
alias dev="git checkout develop"
alias mas="git checkout master"
alias g-="git checkout -"
alias v="vim"
alias gmf='git merge --no-ff'
alias t="tig"
alias todo="$TODO_SH"
alias tdo="$TODO_SH do"
alias tm="todotxt-machine"
alias workman="setxkbmap -v workman && xset r 66"
alias qwerty="setxkbmap gb && xset r 66"
alias qdrwbj="setxkbmap gb && xset r 66"
alias ergodox="setxkbmap us && xset r 66"

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

#ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git autojump history-substring-search gitignore)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/home/nic/.gem/ruby/2.2.0/bin:/home/nic/bin:/usr/local/bin:$PATH"
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

_get_suspended_jobs() {
  # thanks to @mheap for his help
  NUM_JOBS="`jobs | wc -l`"
  if test $NUM_JOBS -lt 1 ; then
    echo ""
  else
    echo "("`jobs | grep ' .*suspended' | sed 's/  . suspended //' | sed 's/\[\([^]]*\)\]/\1:/g' | sed 's/\: /\:/g'`")"
  fi
}

_get_project_todos() {
    local git_dir=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ "$git_dir" != "" ] ; then
        local root_name=$( basename $git_dir )
        local num_proj_todo="$($TODO_SH ls +$root_name | grep '^\S\+\s[^x]' | wc -l | sed -e's/ *//')"
        echo $( expr $num_proj_todo - 1 )
    else
        local root_name=""
        echo "0"
    fi
}

_get_non_project_todos() {
    local git_dir=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ "$git_dir" != "" ] ; then
        local root_name=$( basename $git_dir )
        local num_non_proj_todo="$($TODO_SH ls -+$root_name | grep '^\S\+\s[^x]' | wc -l | sed -e's/ *//')"
    else
        local root_name=""
        local num_non_proj_todo="$($TODO_SH ls | grep '^\S\+\s[^x]' | wc -l | sed -e's/ *//')"
    fi
    echo $( expr $num_non_proj_todo - 1 )
}

ta() {
    if [ $# -eq 0 ]; then
        echo "no arguments given fucktard :("
        return 0
    fi
    local git_dir=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ "$git_dir" != "" ] ; then
       local root_name=$( basename $git_dir )
       $TODO_SH add +$root_name $@
    else
       local root_name=""
       $TODO_SH add $@
    fi
}

tls () {
    local git_dir=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ "$git_dir" != "" ] ; then
       local root_name=$( basename $git_dir )
       $TODO_SH list +$root_name $@
    else
       local root_name=""
       $TODO_SH list $@
    fi
}

RPROMPT='$(_get_suspended_jobs) %{$fg['cyan']%}$(_get_project_todos)%{$reset_color%}|%{$fg['blue']%}$(_get_non_project_todos)%{$reset_color%}'
#THEMIS_HOME='/Users/nic/.vim/bundle/vim-themis/'

BASE16_SHELL="$HOME/.config/base16-shell/base16-ocean.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
