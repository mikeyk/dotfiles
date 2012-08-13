# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="prose"

export DISABLE_COMPLETION_WAITING_DOTS="true"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"
#
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git fabric ec2-ssh cdb git-flow github)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/share/python:/usr/local/pgsql/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/X11/bin:/Users/mkrieger/.ec2/bin:/Users/mkrieger/.ec2/bin

alias ifab='ec2ssh mkrieger@instaproxy ifab'
alias pfab='ec2ssh mkrieger@instaproxy ifab -z 25 -P --linewise'
alias lfab='fab -f ~/src/distillery-deploy/fabfile.py'
alias lpfab='fab -z 35 -P --linewise -f ~/src/distillery-deploy/fabfile.py'
alias update_proxy='ec2ssh mkrieger@instaproxy cd distillery-deploy \&\& git pull origin master'

alias essh="ec2-ssh"
alias push2prod="git push origin develop && git checkout master && git merge develop && git push origin master && git checkout develop"
alias push2munin="git push origin master && pfab munin update_deploy"
alias pullpush="git pull --rebase origin master && git push origin HEAD"
alias pullpush2munin="git pull --rebase origin master && git push origin HEAD && pfab munin update_deploy"
alias ec2host='ec2hostcache'
alias gpr="git pull --rebase origin develop"
. ~/.ec2/prod


#function zle-line-init zle-keymap-select {
    #RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
        #RPS2=$RPS1
            #zle reset-prompt
        #}
#zle -N zle-line-init
#zle -N zle-keymap-select
#bindkey -v
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[^N' newtab
bindkey '^?' backward-delete-char

export VIRTUALENV_USE_DISTRIBUTE=1
export PATH=/Users/mkrieger/pyenv/bin:/Users/mkrieger/.bin:$PATH:~/.ec2
export VIRTUAL_ENV=/Users/mkrieger/pyenv

export JAVA_HOME="$(/usr/libexec/java_home)"

export AWS_CLOUDWATCH_HOME="/usr/local/Cellar/cloud-watch/1.0.12.1/jars"
export SERVICE_HOME="$AWS_CLOUDWATCH_HOME"
export AWS_AUTO_SCALING_HOME=/Users/mkrieger/src/AutoScaling-1.0.49.1
export AWS_ELASTICACHE_HOME="/usr/local/Cellar/aws-elasticache/1.5.0/jars"
export AWS_ELB_HOME="/usr/local/Cellar/elb-tools/1.0.15.1/jars"
export AWS_IAM_HOME="/usr/local/Cellar/aws-iam-tools/1.3.0/jars"

PATH=$AWS_AUTO_SCALING_HOME/bin:$PATH

[[ -s "/Users/mkrieger/.rvm/scripts/rvm" ]] && source "/Users/mkrieger/.rvm/scripts/rvm"  # This loads RVM into a shell session.
 [ -x "/Applications/MacVim.app/Contents/MacOS/Vim" ] && alias vim=/Applications/MacVim.app/Contents/MacOS/Vim

unsetopt correct_all

if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
    eval $(ssh-agent)
fi

ec2id() { ec2who $@ | cut -f 2 }
ec2ip() { ec2who $@ | cut -f 4 }
ec2rename() { ec2tag -t Name=$2 $(ec2id $1) }

export DJANGO_SETTINGS_MODULE='settings'
export PYTHONPATH=~/src/distillery-server/:~/src/distillery-server/distillery/:$PYTHONPATH
