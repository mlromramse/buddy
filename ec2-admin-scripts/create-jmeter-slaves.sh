#!/bin/bash -e
ERROR=""
CREATED=`date +%s`

printf "\n\nThe $0 script is starting\n"

# Prerequisits check

if [[ "$1" == "" ]]; then
  ERROR="$ERROR\n * Number of wanted slaves is required as a parameter to this script."
  ERROR="$ERROR\n   usage: create-jmeter-slaves no-of-slaves\n"
fi

if [[ "$AMI_ID_SLAVE" == "" ]]; then
  ERROR="$ERROR\n * The environment variable AMI_ID_SLAVE has to be set."
fi

if [[ "$AMI_ZONE" == "" ]]; then
  ERROR="$ERROR\n * The environment variable AMI_ZONE has to be set. E.g. eu-west-1a"
fi

if [[ "$KEY_NAME" == "" ]]; then
  ERROR="$ERROR\n * The environment variable KEY_NAME has to be set."
fi

if [[ "$SECURITY_GROUP_SLAVE" == "" ]]; then
  ERROR="$ERROR\n * The environment variable SECURITY_GROUP_SLAVE has to be set."
fi

if [[ "$ERROR" != "" ]]; then
  printf "\nRequired prerequisits are not met:$ERROR\n\n"
  exit 1
fi

echo "Checking running instances..."

NO_OF_SLAVES=""

while [[ "$NO_OF_SLAVES" == "" ]]
do
  NO_OF_SLAVES="`ec2din |grep "$AMI_ID_SLAVE.*running.*$SECURITY_GROUP_SLAVE" |cut -f18 |wc -l`"
done

if [[ $1 -le $NO_OF_SLAVES ]]; then
  printf "\nThere are $NO_OF_SLAVES running jmeter-slave instances already\n\n"
  exit 0
fi

NEW_SLAVES=$(($1-$NO_OF_SLAVES))

echo "Creating $NEW_SLAVES slaves since $NO_OF_SLAVES slaves already was running."

ec2run "$AMI_ID_SLAVE" -k "$KEY_NAME" -g "$SECURITY_GROUP_SLAVE" -t 'm3.medium' -n "$NEW_SLAVES" -z "$AMI_ZONE"


echo "...waiting for pending instances..."

NO_OF_SLAVES=1
while [[ "$NO_OF_SLAVES" != "0" ]]
do
  NO_OF_SLAVES=`ec2din |grep "$AMI_ID_SLAVE.*pending.*$SECURITY_GROUP_SLAVE" |cut -f18 |wc -l`
  echo "...$NO_OF_SLAVES slaves pending..."
done

echo "...tagging the new slaves..."

ec2din |grep "$AMI_ID_SLAVE.*running.*$SECURITY_GROUP_SLAVE" |cut -f2 > instances.log
cat instances.log |ec2tag - --tag "Name=debian-lxde-jmeter-slave $CREATED"

printf "\nThe $0 script has ended\n\n"
