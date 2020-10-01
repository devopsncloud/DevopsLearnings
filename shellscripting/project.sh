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
        payment 
        User
        ;;

esac




