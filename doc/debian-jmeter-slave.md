




# Running instructions for debian-jmeter-slave.packer.json

This documentation contains what you need to know to make use of the debian-jmeter-slave.packer.json file.




## Prerequisits

The same prerequisits as in the README.md documentation




## Create the AMI

This is the command to start creation of this AMI:

	packer build debian-jmeter-slave.packer.json

_The update and upgrade of the Debian default system takes a while so if you have a set of stairs nearby use the working time to excersize._

At the end take a note of the ami identifier, you will need that later.




## Create a set of Instances of the newly created AMI

In the folder ec2-admin-scripts there are a script that is designed to create a number of instances of a given ami identifier.
For that to work there are a set of environment variables that has be set.
The easiest way do discover which is to run the command without any parameters and you will end up with something like this:

	$ ./create-jmeter-slaves.sh 

	Required prerequisits are not met:
	 * Number of wanted slaves is required as a parameter to this script.
	   usage: create-jmeter-slaves no-of-slaves

	 * The environment variable AMI_ID_SLAVE has to be set.
	 * The environment variable KEY_NAME has to be set.
	 * The environment variable SECURITY_GROUP_SLAVE has to be set.



### Set up the environment variables

In order for your server to fully working after a restart you should enter these in your .bashrc, or similar, file.
It should contain a set of rows that starts with export=...
Make new rows that look like this:

	export AMI_ID_SLAVE="THE_AMI_ID_YOU_GOT_WHEN_CREATING_THE_AMI"
	export KEY_NAME="THE_NAME_OF_THE_KEY-PAIR_THAT_YOU_HAVE_ACCESS_TO"
	export SECURITY_GROUP_SLAVE="THE_ID_OF_THE_APPROPRIATE_SECURITY_GROUP"



### Create four slave instances

This is the command to create four slave instances:

	$ ./create-jmeter-slaves 4



## Start Apache JMeter with attaced slaves

The created slaves is used in the script ec2-admin-scripts/start-jmeter.sh.

	$ ./start-jmeter.sh

This script wait while slaves are pending and then connects to them automatically.
