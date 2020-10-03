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
        echo -e "$2 - \e[1;32mSUCCESS\e[0m"
        ;;
    *)
       echo -e "$2 -\e[1;31mFAILED\e[0m"
       
       exit 1
       ;;
    esac
}


Frontend() {
    Heading "Installing Frontend Service"
    yum install nginx -y &>>$LOG_FILE     # terminal output redirecting to log file
    Stat $? "Nginx-Install\t\t"
    curl -s -L -o /tmp/frontend.zip "https://dev.azure.com/DevOps-Batches/98e5c57f-66c8-4828-acd6-66158ed6ee33/_apis/git/repositories/65042ce1-fdc2-4472-9aa2-3ae9b87c1ee4/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
    Stat $? "Download frontend files" &>>$LOG_FILE

    cd /usr/share/nginx/html
    rm -rf *

    unzip /tmp/frontend.zip &>>$LOG_FILE
    Stat $? "Extract frontend files  "

    mv static/* .
    rm -rf static README.md
    mv localhost.conf /etc/nginx/nginx.conf

    systemctl enable nginx &>>$LOG_FILE
    systemctl start nginx &>>$LOG_FILE
    Stat $? "Start Nginx\t\t"
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




