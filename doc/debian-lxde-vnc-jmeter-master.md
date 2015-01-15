




# Running instructions for debian-lxde-vnc-jmeter-master.packer.json

This documentation contains what you need to know to make use of the debian-lxde-vnc-jmeter-master.packer.json file.

The creation of instances from the AMI debian-jmeter-slave.packer.json is supposed to be managed from this AMI. More of that later.




## Prerequisits

The same prerequisits as in the README.md documentation




## Create the AMI

This is the command to start creation of this AMI:

	packer build debian-lxde-vnc-jmeter-master.packer.json

_The build will take a while so if you are in to coffee you are in luck, you will have ample time to brew yourself a nice cup. I would say you also have time to run down to the store and buy a bun or a cake._




## Launch the Instance

We now need to launch the instance based on the previously created AMI.
The easiest way to do this, more than once, is to use ec2-api-tools.
If your goal is to just do this once do it through the Amazon/ec2 web gui;
a step by step instruction can be found in the README.md.



### Launching via ec2-api-tools

Before using the ec2-api-tools you need to set the necessary environment variables.

ec2run AMI_IMAGE_ID 




## Control the Instance via VNC viewer

When the instance is up and running, make a note