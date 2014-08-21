#!/bin/bash
ERROR=""

printf "\n\nThe $0 script is starting\n"

# Prerequisits

if [[ "$AMI_ID_SLAVE" == "" ]]; then
  ERROR="$ERROR\n * The environment variable AMI_ID_SLAVE has to be set."
fi

if [[ "$SECURITY_GROUP_SLAVE" == "" ]]; then
  ERROR="$ERROR\n * The environment variable SECURITY_GROUP_SLAVE has to be set."
fi

if [[ "$ERROR" != "" ]]; then
  printf "\nRequired prerequisits are not met:$ERROR\n\n"
  exit 1
fi



ec2din |grep "$AMI_ID_SLAVE.*running.*$SECURITY_GROUP_SLAVE" |cut -f2 |ec2kill -

printf "\n\nThe $0 script has ended.\n"
