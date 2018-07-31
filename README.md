# network_cofiguration
This repository consists of a shell script to configure a network using raspberry pi. 



### Introduction

This document consists of how to use the bash script

##### Note:
Everything we do with this script is through the computer terminal so go ahead and fire up your terminal.
### Getting started
To run this script on your computer you first need to give executing rights to the file.yoNext step is to cd into the directory on your computer where ever you decide to save the file and type the following command:

    ls -l

ls will list all the files in that directory
"-l" will list all the rights that you have for the file in that folder.

You will see something like this on your terminal window after exexuting the command.

    -rw-r--r--@ 1 shehjarsadhu  staff  653 Jun 26 13:12 config_pi.sh
    -rw-r--r--@ 1 shehjarsadhu  staff  418 Jun 26 15:36 readmeBash.md

* r : Refers to read
* w : write
* x : execute

You will not see an x in .sh file at first. This is because executable rights are disabled by default at first.

Run the following command in your terminal window.

    chmod 755 config_pi.sh

chmod enables the executable rights. Now do

    ls -l


You should see something like this:


        shehjars-MacBook-Pro:PiConfig shehjarsadhu$ ls -l
        total 12
        -rwxr-xr-x 1 growhub growhub  638 Jun 27 09:07 config_pi.sh
        -rw-rw-r-- 1 growhub growhub 1558 Jun 27 09:36 readmeBash.md
You should see x now that indicates executable rights.


### Running the Script

Once you have the executable rights you are now ready to execute it.Type the following command in your terminal window.

    ./config_pi.sh

Do what it asks and you are all set to go  :)
