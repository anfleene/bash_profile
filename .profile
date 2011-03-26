
# MacPorts Installer addition on 2009-08-10_at_11:01:37: adding an appropriate PATH variable for use with MacPorts.
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/nginx/sbin:$PATH
export PATH=/Library/Perl/5.10.0/auto/share/dist/Cope:$PATH
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export MAGICK_HOME="/usr/local/ImageMagick-6.6.5"
export PATH="$MAGICK_HOME/bin:$PATH"
export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib"

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


#[[ $- == *i* ]] && . ~/.bash_files/git-prompt.sh
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

alias tail_prod='prod tail -f /opt/local/nginx/logs/access.log'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
alias javac6='/usr/lib/jvm/java-6-sun-1.6.0.07/bin/javac'
alias java6='/usr/lib/jvm/java-6-sun-1.6.0.07/bin/java'
# alias ls='ls -a'
alias rebash='source ~/.profile'
alias e='$EDITOR'
alias mr='cd ~/mobi'

#git aliases
alias gco='git checkout'
alias gr='git rebase'
alias gm='git merge'
alias gci='git commit -v'
alias gca='git commit -v -a'
alias ga='git add'
alias grm='git rm'
alias gst='git status'
alias gb='git branch'
alias gba='git branch -a'
alias gf='git fetch'
alias gft='git fetch --tags'
alias gt='git tag'
alias gblame='git blame'
alias gstash='git stash'
alias gdiff='git diff'
alias glog='git log'
alias gl='git pull'
alias gp='git push'
alias gd='git diff|e'
alias wtf='git wtf'
alias gls='git ls-files -u'
alias gbt='git branch --track'
alias gtrefresh='git tag -d `git tag`; git fetch --tags'
alias ack='ack --color'

alias bi='bundle install'

alias console='script/console'

function cdf() {
  cd *$1*/
}


function mobi_mysql_load(){
  #get the newest production mysql backup from s3
  s3cmd get `ruby -e 'puts %x[s3cmd ls s3://mobi-db-backups/production-*].split("\n").last.match(/s3:\/\/.+/)'`
  #get the gziped file that was just pulled
  file=`ls production-*`
  gunzip $file
  file=`ls production-*`
  #the single argument is for which database to dump it (you may want to change the default to match your config
  if [ $# -lt 1 ]
    then
      db="mobi_development"
    else
      db=$2
  fi
  #dump that shizz into mysql
   mysqldump -uroot  --add-drop-table --no-data $db | grep ^DROP | mysql -uroot $db
   mysql -h localhost -u root  $db < $file
   rm $file
}

function mobi_mongo_load () {
  #mongo gets messy lets put it in a new dir we can delete later
  mkdir production-mongo
  cd production-mongo
  #get latest mongo backup from s3
  s3cmd get `ruby -e 'puts %x[s3cmd ls s3://mobi-mongo-backups/production-mongo-*].split("\n").last.match(/s3:\/\/.+/)'`
  file=`ls production-mongo-*`
  tar zxf $file
  #set the mongo dir to be last nights production back up(the mobi dir)
  mongoDir=tmp/`ls tmp/`/mobi
	if [ $# -lt 1 ]
	  then
	    db="mobi_sandbox"
		else
			db=$1
	fi
  #dump it into mongo
	mongo $db --eval "db.dropDatabase();"
  mongorestore --indexesLast --db $db $mongoDir
  #cleanup
  cd ..
  rm -rf production-mongo
}


function hup_mongod(){
	sudo kill -9 `pidof mongod`
	sudo rm /usr/local/mongodb_data/mongod.lock
	sudo mongod --dbpath /usr/local/mongodb_data/
}

function hup_mysql(){
  sudo kill -9 `pidof mysqld`
}

function clearlogs(){
	cat /dev/null > log/development.log
	cat /dev/null > log/test.log
}

function cap(){
  git pull
  `which cap` $@
}

function wiki() { dig +short txt $1.wp.dg.cx; }

function reset_dnsmasq(){
  sudo launchctl unload -w /Library/LaunchDaemons/uk.org.thekelleys.dnsmasq.plist
  sudo launchctl load -w /Library/LaunchDaemons/uk.org.thekelleys.dnsmasq.plist
}
alias test='RAILS_ENV=test'
alias test:reset='test rake db:migrate:reset'




#class path
CLASSPATH=/usr/local/mysql-connector-java/mysql-connecter-java-5.1.7-bin.jar
export CLASSPATH
#extend path

PATH=$PATH:/home/anfleene/.gem/ruby/gems/1.8:/usr/local/mongodb/bin
export PATH

alias prod='ssh $prod'
alias derp='ssh $mrderp'
alias mrt='ssh $mrt'

#bashrc
profile=~/.bash/.profile
export profile

alias ebash='e $profile'
alias ebashrc='e ~/.bash/.bashrc'


# include bashrc
source ~/.bash/.bashrc

EDITOR='mvim -f'
export EDITOR

BLACK="\[\033[0;38m\]"
RED="\[\033[0;31m\]"
RED_BOLD="\[\033[01;31m\]"
BLUE="\[\033[01;34m\]"
GREEN="\[\033[0;32m\]"
export PS1="$BLACK\u@$RED\h$GREEN\w$RED_BOLD $RED_BOLD\`ruby ~/.branch_name\`\[\033[37m\]$\[\033[00m\] "

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
