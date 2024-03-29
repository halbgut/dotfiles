export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux wd)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH=$PATH:/usr/local/m-cli
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run alias.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

## CUSTOM ALIASES
alias meteor-create='project_name=basename ${PWD} && meteor create ${project_name} && mv ${project_name}/{*,.*} ./ 2>/dev/null && rmdir ${project_name}'

export NVM_DIR="/Users/kriegslustig/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export GOPATH=$HOME/Software/Go

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"

export NODE_ENVIRONMENT="DEVELOPMENT"

alias ll='ls -lah'

export LANG=en_GB

export EDITOR=vim


function warp {
  for bin in /usr/bin/warp /usr/local/bin/warp; do
    if [ -f ${bin} ]; then
      if [[ ${1} == "list" || ${1} == "add" ]]; then
        ${bin} ${*}
      else
        result=$(${bin} ${1})
        if [[ ${result} != "No warps found" ]]; then
          cd $(${bin} ${1})
        else
          echo ${result}
        fi
      fi
    fi
  done
}

alias c='curl'

alias dm='docker-machine'
alias dme='eval $(dm env)'
alias dmr='dm restart && dme'
function docker-clean {
  docker rm "$(docker ps -aq)"
  docker rmi "$(docker images -q)"
}
alias docc='docker-compose'
alias updatedb='sudo /usr/libexec/locate.updatedb'

#export PATH="/Users/kriegslustig/.rvm/gems/ruby-2.2.1/bin:/Users/kriegslustig/.rvm/gems/ruby-2.2.1@global/bin:/Users/kriegslustig/.rvm/rubies/ruby-2.2.1/bin:/usr/local/bin:

alias ssh2horst="~/dotfiles/ssh2horst.bash"

sbb () {
  open "http://fahrplan.sbb.ch/bin/query.exe/dn?S=${1}&Z=${2}"
}

npmi () {
  local packagename=$(echo ${@} | sed -E 's/.* ([a-zA-Z0-9\-]+)$/\1/g')
  local opt
  npm info ${packagename} | less
  echo "Is it the right package? (y/n)"
  read opt
  if [[ "${opt}" == "y" ]]; then
    npm i ${@}
  fi
}

npmr () {
  npm run --silent ${@}
}

alias prettyjson='python -m json.tool'

function mov2gif {
  ffmpeg -i ${1} -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3
}

if which thefuck 1>/dev/null; then
  eval "$(thefuck --alias)"
fi

if [ -f ~/.zshrc_secret ]; then
  source ~/.zshrc_secret
fi

eval "$(jump shell zsh)"

merge-branch () {
  git merge --no-ff --no-edit ${1} && \
  git push && \
  git branch -d ${1} && \
  git push --delete origin ${1}
}

open-node-project () {
  PROJECT_DIR="$(pwd)"
  tmux new-window -c ${PROJECT_DIR} -t default
  tmux split-window -t 'default:{end}' -h -p 50 -c ${PROJECT_DIR}
  tmux split-window -t 'default:{end}' -h -p 50 -c ${PROJECT_DIR}
  tmux new-window -c ${PROJECT_DIR} -t default 'reattach-to-user-namespace -l /bin/zsh; nvim'
}

alias prettyJson=node -e 'process.stdin.on("data", (d) => console.log(JSON.stringify(JSON.parse(d.toString()), null, "  ")))'

export FZF_DEFAULT_COMMAND='fd --type f'

bindkey "\e[1;3C" forward-word
bindkey "\e[1;3D" backward-word
