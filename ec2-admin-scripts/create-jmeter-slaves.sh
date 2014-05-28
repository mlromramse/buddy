#!/bin/bash -e

ERROR=""

# Prerequisits check

if [[ "$1" == "" ]]; then
  ERROR="$ERROR\n * Number of wanted slaves is required as a parameter to this script."
  ERROR="$ERROR\n   usage: create-jmeter-slaves no-of-slaves\n"
fi

if [[ "$AMI_ID_SLAVE" == "" ]]; then
  ERROR="$ERROR\n * The environment variable AMI_ID_SLAVE has to be set."
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
  exit 1
fi

NEW_SLAVES=$(($1-$NO_OF_SLAVES))

ec2run "$AMI_ID_SLAVE" -k "$KEY_NAME" -g "$SECURITY_GROUP_SLAVE" -t 'm3.medium' -n "$NEW_SLAVES"

