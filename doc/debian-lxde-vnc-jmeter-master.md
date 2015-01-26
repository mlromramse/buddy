




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

When the instance is up and running, make a note of its ip address (e.g. 74.31.92.0). This is to be used to connect to the machine via your vncviewer.

	vncviewer 74.31.92.0:5901

When your jmeter master is viewable in your vnc viewer you can instantly start jmeter and build a script to be run.

	jmeter

_Please note that the jmeter log file is created in the folder where you started jmeter. This might be a file you want in a specific directory. If so go to that directory before starting jmeter._




## Activate several slaves for jmeter to use

This setup is prepared to create and use several jmeter slaves for very heavy load tests. A set of scripts has been created to simplify this process:

* __create-jmeter-slaves.sh__ - Makes use of ec2-api-tools to create a desired amount of slaves.
* __killall-jmeter-slaves.sh__ - Terminates all slaves created by the script above.
* __pipe-ip-copy.sh__ - Copies a file to all slaves
* __start-jmeter__ - Create slaves, starts JMeter and kills the slaves after JMeter is closed.

The recommended way to create slaves is with the `start-jmeter` script since that will not only automatically attach the slaves to JMeter but also automatically will terminate the slaves when you quit JMeter. Important since running slaves costs money.

##### The way to do it

1. Enter your preferred folder.
2. Start JMeter with `~/buddy/ec2-admin-scripts/start-jmeter 10` in case you want 10 slaves to use.
3. The process of creating the slaves will be visible to you in the console and when all slaves are up, tagged and running JMeter will start.
4. Use JMeter as you normally would; open a script or create a new one.
5. Run normally with Ctrl+R to control the script results.
6. Run the same script on all slaves with Ctrl+Shift+R. The slaves results will be returned to your JMeter and reported together in the JMeter GUI.

_Be aware that in case your script relies on an external file you will need to run the `pipe-ip-copy.sh` script to copy that file to all slaves before starting the slave run. You will need another console to do this._

