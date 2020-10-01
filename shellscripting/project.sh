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

#Creating a temporary log file to hide terminal output
touch /tmp/roboshop.log
LOG_FILE=/tmp/roboshop.log  #creates a temp logfile
rm -f $LOG_FILE               # Clears the log content before the script runs

Frontend() {
    echo "Installing Frontend Service"
    yum install nginx -y &>$LOG_FILE     #output of the installation is redirecting to logfile
    case $? in
         0)
        echo "Nginx Install - SUCCESS"
        ;;
    *)
       echo "Nginx Install - FAILED"
       
       exit 1
       ;;
    esac
}


MongoDB() {
    echo "Installing MongoDB"
}


Redis() { 
    echo "Installing Redis"
}

MySQL() {
    echo "Installing MySQL"
}

RabbitMQ() {
    echo "Installing RabbitMQ"
}

Cart() {
    echo "Installing Cart"
}

Catalogue() {
    echo "Installing Catalogue"
}


Shipping() {
    echo "Installing Shipping"
}

Payment() {
    echo "Installing Payment"
}


User() {
    echo "Installing User"
} 


USAGE() {
    echo -e "Usage \t\t   : $0 Component"
    echo -e "Components \t   : Frontend, MongoDB, Redis, MySQL, RabbitMQ , Cart, Catalogue, Shipping, Payment, User"
    echo For all Components : All
    exit 1
}




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




