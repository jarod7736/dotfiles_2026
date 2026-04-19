# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/jarod7736/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="half-life" # set by `omz`
#ZSH_THEME="wezm"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
 ZSH_THEME_RANDOM_CANDIDATES=("half-life" "strug" "kafeitu" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sbt python)

export HOME="/home/jarod7736"

source $ZSH/oh-my-zsh.sh

# User configuration

# Set up ssh-agent
SSH_ENV="$HOME/.ssh/environment"

#exec ssh-agent zsh
#eval ssh-agent -s

 function start_agent {
     echo "Initializing new SSH agent..."
     touch $SSH_ENV
     chmod 600 "${SSH_ENV}"
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' >> "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
    #/usr/bin/ssh-add
		/usr/bin/ssh-add ~/.ssh/id_ed25519
 }
 
# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
	. "${SSH_ENV}" > /dev/null
kill -0 $SSH_AGENT_PID 2>/dev/null || {
 start_agent
}
else
start_agent
fi
start_agent

# export MANPATH="/usr/local/man:$MANPATH"

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias pull="git pull"
alias commit="git commit -m"
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias pip="pip3"
alias python="python3"
alias sbt="sbt"
alias css="~/.local/share/coursier/bin/cs"
export GITHUB_TOKEN="bda7e63f56092fcb2addf3bf0baa4a5fb4137885"
export SPARK_HOME="/home/jarod7736/.local/lib/python3.6/site-packages/pyspark/"

export BROWSER=/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exedKeysToAgent yes

export PATH="$HOME/bin/:$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/mnt/c/Program Files/WindowsApps/CanonicalGroupLimited.UbuntuonWindows_1804.2019.521.0_x64__79rhkp1fndgsc:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Windows/System32/OpenSSH/:/mnt/c/Program Files/Intel/WiFi/bin/:/mnt/c/Program Files/Common Files/Intel/WirelessCommon/:/mnt/c/Users/jarod/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/jarod/AppData/Local/Programs/Microsoft VS Code/bin:/home/jarod7736/.vimpkg/bin/:/home/jarod7736/tools/sbt/bin/:/home/jarod/bin/kafka/bin/:$HOME/.conscript/bin/:$HOME/.cargo/env:$HOME/.cargo/bin/:$HOME/.platformio/penv/bin:$HOME/.arduino/bin"

if [ -e /home/jarod7736/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jarod7736/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

emulate sh -c '. ~/.profile'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/jarod7736/micromamba/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/jarod7736/micromamba/etc/profile.d/conda.sh" ]; then
#        . "/home/jarod7736/micromamba/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/jarod7736/micromamba/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Machine-local overrides (not tracked in git)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
