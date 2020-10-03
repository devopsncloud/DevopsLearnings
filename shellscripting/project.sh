#!/bin/bash

#Frontend
#MongoDB
#Redis
#MySQL
#RabbitMQ  
#Cart
#Catalogue
#Shipping
#payment 
#User
#All

Heading() {
echo -e "\t\t\e[1;4;35m$1\e[0m"
}


Stat(){
case $1 in
         0)
        echo "$2 - SUCCESS"
        ;;
    *)
       echo "$2 - FAILED"
       
       exit 1
       ;;
    esac
}


Frontend() {
    Heading "Installing Frontend Service"
    yum install nginx -y &>$LOG_FILE     # terminal output redirecting to log file
    Stat $? "Nginx-Install"
}


MongoDB() {
    Heading "Installing MongoDB Service"
}


Redis() { 
    Heading "Installing Redis Service"
}

MySQL() {
    Heading "Installing MySQL Service"
}

RabbitMQ() {
    Heading "Installing RabbitMQ Service"
}

Cart() {
    Heading "Installing Cart Service"
}

Catalogue() {
    Heading "Installing Catalogue Service"
}


Shipping() {
    Heading "Installing Shipping Service"
}

Payment() {
    Heading "Installing Payment Service"
}


User() {
    Heading "Installing User Service"
} 


USAGE() {
    echo -e "Usage \t\t   : $0 Component"
    echo -e "Components \t   : Frontend, MongoDB, Redis, MySQL, RabbitMQ , Cart, Catalogue, Shipping, Payment, User"
    echo For all Components : All
    exit 1
}

## Main program ##

#Creating a temporary log file to hide terminal output  
LOG_FILE=/tmp/roboshop.log  
rm -f $LOG_FILE      

#Setting a condition for the script to run only as a root 
USER_ID=$(id -u)
case $USER_ID in
     0) true
     ;;
    *)
        echo "Script should be run as a root "
        USAGE
        ;;
esac


case $1 in 

  Frontend)
   Frontend
   ;;

  MongoDB)
   MongoDB
   ;;

  Redis)
   Redis
   ;;

  MySQL)
   MySQL
   ;;

  RabbitMQ)
   RabbitMQ
   ;;   

   Cart)
    Cart
    ;;

   Catalogue)
    Catalogue
    ;;

    Shipping)
     Shipping
     ;;

    Payment)
     Payment
     ;;

    User)
     User
     ;;  

    All)
        Frontend
        MongoDB
        Redis
        MySQL
        RabbitMQ  
        Cart
        Catalogue
        Shipping
        Payment 
        User
        ;;


    *)
    USAGE
    ;;   

esac




