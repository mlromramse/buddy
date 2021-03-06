#!/bin/bash -e
DIR=`dirname $0`
ERROR=""

printf "\n\nThe $0 script is starting\n"


if [[ $1 != "" ]]; then
	if [[ $1 == "--help" || $1 == "-h" ]]; then
		echo "usage:  start-jmeter.sh no-of-slaves"
		exit 0
	fi
	WANTED_NO_OF_SLAVES=$(($1))
	echo "$WANTED_NO_OF_SLAVES slaves wanted."
	if [[ $WANTED_NO_OF_SLAVES == 0 ]]; then
		ERROR="$ERROR\n * Wanted number of slaves has to be greater than 0."
	fi
fi

# Prerequisits

if [[ "$AMI_ID_SLAVE" == "" ]]; then
  ERROR="$ERROR\n * The environment variable AMI_ID_SLAVE has to be set."
fi

if [[ "$SECURITY_GROUP_SLAVE" == "" ]]; then
  ERROR="$ERROR\n * The environment variable SECURITY_GROUP_SLAVE has to be set."
fi

if [[ `ps -ef |grep "bin/jmeter" |wc -l` -gt 1 ]]; then
  ERROR="$ERROR\n * There is already a jmeter master running."
fi

if [[ "$ERROR" != "" ]]; then
  printf "\nRequired prerequisits are not met:$ERROR\n\n"
  exit 1
fi


# Create slaves phase

if [[ WANTED_NO_OF_SLAVES -gt 0 ]]; then
	echo "There are $WANTED_NO_OF_SLAVES slaves wanted, creating..."
	"$DIR/"create-jmeter-slaves.sh "$WANTED_NO_OF_SLAVES"
fi

echo "Checking running instances..."

NO_OF_SLAVES="1"

echo "...waiting for pending instances..."

while [[ "$NO_OF_SLAVES" != "0" ]]
do
  ec2din |grep "$AMI_ID_SLAVE.*pending.*$SECURITY_GROUP_SLAVE" |cut -f18 > current_slaves_ip
  NO_OF_SLAVES=`cat current_slaves_ip |wc -l`
done

echo "...getting no of instances..."

ec2din |grep "$AMI_ID_SLAVE.*running.*$SECURITY_GROUP_SLAVE" |cut -f18 > current_slaves_ip
NO_OF_SLAVES=`cat current_slaves_ip |wc -l`

echo "...setting preferences..."

cp /opt/apache-jmeter-2.11/bin/jmeter.properties ~/.

echo "remote_hosts=`cat current_slaves_ip |paste -s -d, -`" >> ~/jmeter.properties

echo "...starting jmeter with $NO_OF_SLAVES slaves attached."



# Kill slaves phase

if [[ WANTED_NO_OF_SLAVES -gt 0 ]]; then
	echo "$WANTED_NO_OF_SLAVES slaves where created from this script."
	echo "They will be terminated when JMeter ends, thus running Apache JMeter in the foreground."
	/opt/apache-jmeter-2.11/bin/jmeter -p ~/jmeter.properties &> jmeter-running.log
	echo "$WANTED_NO_OF_SLAVES slaves where created from this script, killing them all."
	"$DIR/"killall-jmeter-slaves.sh
else
	echo "No slaves where created from this script, thus running Apache JMeter in the background."
	/opt/apache-jmeter-2.11/bin/jmeter -p ~/jmeter.properties &> jmeter-running.log &
fi

printf "\n\nThe $0 script has ended\n"
echo

:

