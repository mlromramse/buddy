#!/bin/bash -e

ERROR=""

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

/opt/apache-jmeter-2.11/bin/jmeter -p ~/jmeter.properties &> jmeter-running.log &

echo

:

