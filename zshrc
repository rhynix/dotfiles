function is_git {
  [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
}

function git_branch {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

function is_git_dirty {
  [[ -n $(git diff --shortstat 2> /dev/null | tail -n1) ]]
}

function git_dirty_prompt {
  if is_git_dirty; then
    echo "%{$fg[red]%} *%{$fg[magenta]%}"
  fi
}

function git_prompt {
  if is_git; then
    echo " (%{$fg[yellow]%}$(git_dirty_prompt)%{$fg[magenta]%})"
  fi
}

function source_envrc {
  file=.envrc

  if [[ -f "$file" ]]; then
    source $file
    echo -e "\\033[0;32m$file sourced\\033[0m"
  else
    echo -e "\\033[0;31m$file does not exist\\033[0m"
  fi
}

function nvim_with_custom_vimrc {
  if [[ -n "$VIMRC" ]]; then
    nvim -u $VIMRC "$@"
  else
    nvim "$@"
  fi
}

alias "nvim"="nvim_with_custom_vimrc"
alias "source-envrc"="source_envrc"

export EDITOR="nvim"
export GIT_EDITOR=$EDITOR
export GPG_TTY=$(tty)
export XDG_DATA_HOME=$HOME/.data
export XDG_CONFIG_HOME=$HOME/.config
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export CHNODE_NODES_DIR=/opt/nodes

export PATH=~/.bin:$PATH

export PS1='%{$fg[magenta]%}%1d%{$reset_color%}: '

autoload -U compinit && compinit
autoload -U colors && colors
setopt promptsubst
bindkey -e

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chnode/share/chnode/chnode.sh
