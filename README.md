




# Buddy - The AMI creator

Buddy is an open source project to simplify creation of Amazon Machine Images.
The goal for this project is to create regeneratable images with the help of packer.
The project can create these images with a simple command line execution:

* Debian VNC enabled server for cloud side graphical verifications like running Apache JMeter or testing web pages.




## Prerequisits

You must have an Amazon account before starting to use buddy. A free one is on offer from Amazon. Not in any way related to this project though.

These applications has to be installed on your system to be able to use this project:

* Java JRE - install in the best way for your system.
* Packer - can be downloaded from http://www.packer.io/downloads.html
* ec2-api-tools - can be downloaded from https://aws.amazon.com/developertools/351. Follow instructions on this page to get it installed: http://docs.aws.amazon.com/AWSEC2/latest/CommandLineReference/set-up-ec2-cli-linux.html



### Important

Make sure to set up all the environment variables that is needed for packer and ec2-api-tools.
Remember to put your environment variable setup in your .bashrc or similar file.
Without these you will fail to do anything with buddy.

* AWS_ACCESS_KEY - your personal aws access key to your account on Amazon
* AWS_SECRET_KEY - your personal aws secret key to your account on Amazon
* JAVA_HOME - the path to your java installation, where the bin, jre and lib folders live
* EC2_HOME - where the bin folder lives that contains all the applications that start with ec2.
* PATH - update your path to find the ec2 applications. Normally `export PATH=$PATH:EC2_HOME/bin`. Make sure to add this to your .bashrc or similar file.




## Structure of the project

In the root folder there are a set of packer.json script files that make use of the files elsewhere in the project.
The project copies files to the AMI and installs applications.



### Folders

* root folder - here you find the packer.json files that conducts the AMI creation.
* files - all the files in this folder is copied to the AMI folder `/home/admin`.
* scripts - a set of scripts that is used by the packer.json files in the root directory of this project.




## Extending the project

We are very pleased if you would like to fork and extend our project with your findings.
Please provide us with your pull request at will.
However, please keep it clean and do not make changes that will affect previously created packer.json files and scripts.

From the beginning we have been planned for this and as you can see we let our packer.json files call several script files altough it stricktly isn't needed. Add as many interesting scripts as you like and leave the ones created alone. Of course you can fix things that is broken, time tends to do that eventually.




## Using the predefined packer script

If you have succeeded in performing all the prerequisits above you should be able to use the packer script.



### Creating a debian-lxde-vnc AMI

Running this script will not create a running instance on your amazon account, only an AMI that you later can use to instantiate one or more instances in your amazon account.
See details about how to do that below.

	$ packer build debian-lxde-vnc.packer.json

_This command executed in your terminal window will start several things that will scroll by. It will take a while and at the end you will be presented with the ami-identifier._



### Launch an instance of the created AMI

When the process above has finalized completely you will have an AMI in your personal list of AMIs.
Do this to launch an instance:

1. Log in to the amazon aws console using your web browser.
2. Select the EC2 Service.
3. On the left hand side select IMAGES/AMIs.
4. Locate the newly created AMI by its name `debian-lxde-vnc nnnnnnnnnn` or the AMI identifier that the script provided you with at the end. The number is a Linux Epoch timestamp telling you when it was created should you have more than one. To find out the date enter this in a terminal `date -d @nnnnnnnnnnnn`
5. Click on that AMI in the name-column to mark it with the blue dot at the beginning of the row.
6. Click on the blue `[ Launch ]` button.
7. In the second step, of this wizard, you can make a selection by choice of the type of machine you want. For testing purpose you can accept the default values and just continue. You will get a micro instance that is very cheap if not free of charge - depends on the age of your account I guess.
8. The third step can also be accepted as is.
9. The fourth step as well.
10. To be able to recognize the instance later - give it a descriptive name. I recommend `debian-lxde-vnc-something` in case you will create more, of the same type, later on.
11. When we come to sixth step, the security group, we need to make some changes. Either select a previously created security group that has port 22 and 5901 open for inbound access or create a new one with a good name and description _(you will appreciate this at a later stage)_. 
	a. Leave the default port 22 but change the ip address to `My IP`.
	b. Add another `Custom TSP Rule` with port 5901 and Source `My IP`
12. Click on `[ Review and Launch ]` and make sure there are no warnings on the page you get.
13. Click on `[ Launch ]`
14. On this final step you have to select a key-pair that you have access to. Do that and tick the `I aknowledge...` checkbox and click the `[ Launch Instances ]` button.
15. Click on the `[ View Instances ]` button to go back to your list of instances. In that view you will find your instance pending and slowly starting. When the Status Checks has gone through you can access the instance through your VNC Viewer of choice or by SSH.



### View the instance through your VNC Viewer

To connect to the instance using a VNC Viewer you have to find the public IP address to the instance. 
It is visible in the column Public IP but if you want to copy it you have to do that from the detailed view.
Click on the instance and mark and copy in the pane below the instance list.

Enter the ip found, eg 123.45.67.89, followed by colon and 5901 to connect to the VNC server on the instance.

	123.45.67.89:5901

_You will shortly be asked for a password. In this setup the password is `password`. Unsecure as this is you can change that yourself if you want._



### Connect to the instance using SSH

When connecting to the instance from your terminal the way to do this is quite different:

1. Select the instance by clicking its name.
2. Click on the `[ Connect ]` button.
3. Follow the instructions on the page shown.




## Delete a previously created AMI

For some reason there isn't a delete action for an AMI.
In this case the action is `Deregister`.

1. Right click on the name of the AMI that you do not want anymore.
2. Select the `Deregister` option.
3. Verify and click the `[ Continue ]` button.

