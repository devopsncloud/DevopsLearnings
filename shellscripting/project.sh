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

Frontend() {
    echo "Installing Frontend"
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
    echo "Usage \t\t: $0 Component"
    echo Components\t: Frontend, MongoDB, Redis, MySQL, RabbitMQ , Cart, Catalogue, Shipping, Payment, User
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




