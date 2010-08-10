
# MacPorts Installer addition on 2009-08-10_at_11:01:37: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2009-08-10_at_11:01:37: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH
# Finished adapting your MANPATH environment variableiable for use with MacPorts.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
alias javac6='/usr/lib/jvm/java-6-sun-1.6.0.07/bin/javac'
alias java6='/usr/lib/jvm/java-6-sun-1.6.0.07/bin/java'
# alias ls='ls -a'
alias rebash='source ~/.profile'
alias e='mate'
alias mr='cd ~/mobi'
alias 362='cd ~/CSCI362'
alias 355='cd ~/CSCI355'
alias 342='cd ~/Sites/CSCIN342'
alias 305='cd ~/CSCIN305'
alias 402='cd ~/CSCI402'
alias datareset='rake db:migrate:reset; rake db:bootstrap; rake spec:db:fixtures:load'
alias populate='rake db:populate[1]; rake db:populate_more; rake db:populate_activity'

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
alias gblame='git blame'
alias gstash='git stash'
alias gdiff='git diff'
alias gl='git pull'
alias gp='git push'
alias gd='git diff|e'
alias wtf='git wtf'
alias gls='git ls-files -u'
alias gbt='git branch --track'
alias ack='ack --color'

alias bi='bundle install'



alias console='script/console'

function mobi() { 
  cd ~/mobi && script/server
}

function mobi_helpers() {
  mailtrap stop;
	mailtrap start;
  sudo memcached -d -u root
}

function db:seed() {
	rake db:fixtures:load FIXTURES_PATH=db/data FIXTURES=$1
}

function mobi_backup_load(){
	if [ $# -lt 2 ]
	  then
	    db="mobi_development"
		else
			db=$2
	fi
	 mysqldump -uroot  --add-drop-table --no-data $db | grep ^DROP | mysql -uroot $db
	    mysql -h localhost -u root  $db < $1
}

function pid () {
	local i
 	for i
  	do
    	ps acx | sed -n "s/ *\([0-9]*\) .* $i *\$/\1/p"
  	done
}

function clearlogs(){
	cat /dev/null > log/development.log
	cat /dev/null > log/test.log
}

function wiki() { dig +short txt $1.wp.dg.cx; }


alias test='RAILS_ENV=test'
alias test:reset='test rake db:migrate:reset'
alias autospec='test:reset; autospec'
alias cucumber='test cucumber'




#class path
CLASSPATH=/usr/local/mysql-connector-java/mysql-connecter-java-5.1.7-bin.jar
export CLASSPATH
#extend path

PATH=$PATH:/home/anfleene/.gem/ruby/gems/1.8
export PATH


alias pegasus='ssh $pegasus'
alias corsair='ssh $corsair'
alias production='ssh $production'
alias demo='ssh $demo'
alias sandbox='ssh $sandbox'
alias stage='ssh $stage'
alias roshambo='ssh $roshambo'
alias mrt='ssh $mrt'
alias mypages='ssh $mypages'
alias quarry='ssh $quarry'



#bashrc
profile=~/.bash/.profile
export profile

alias ebash='e $profile'

# include bashrc
source ~/.bash/.bashrc

EDITOR=mate
export EDITOR 

BLACK="\[\033[0;38m\]"
RED="\[\033[0;31m\]"
RED_BOLD="\[\033[01;31m\]"
BLUE="\[\033[01;34m\]"
GREEN="\[\033[0;32m\]"
export PS1="$BLACK\u@$RED\h$GREEN\w$RED_BOLD $RED_BOLD\`ruby ~/.branch_name\`\[\033[37m\]$\[\033[00m\] "

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm