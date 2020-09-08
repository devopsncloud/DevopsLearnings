#!/bin/bash

echo "Hello!! Srikanth"
echo
echo How are you!!!


#printing multiple lines 

echo -e "Hello  srikanth\n Good Morning!!!"

# color codes
#---------------------------
#color         code
#---------------------------
#Red   --------->   31
#Green --------->   32
#Yellow --------->  33
#Blue   --------->  34
#Magneta ---------> 35
#Cyan   --------->  36


#syantax : echo -e "\e[COLOR-CODEmMESSAGE"

echo -e "\e[30mSRIAKNTH"
echo -e "\e[31mSRIAKNTH"
echo -e "\e[32mSRIAKNTH"
echo -e "\e[33mSRIAKNTH"
echo -e "\e[34mSRIAKNTH"
echo -e "\e[35mSRIAKNTH"
echo -e "\e[36mSRIAKNTH"


echo This shouldnt print any color