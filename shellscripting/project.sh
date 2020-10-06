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
        echo -e "\t$2 - \e[1;32mSUCCESS\e[0m"
        ;;
    *)
       echo -e "\t$2 -\e[1;31mFAILED\e[0m"
       
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

    unzip -o /tmp/frontend.zip &>>$LOG_FILE
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
    echo '[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc' >/etc/yum.repos.d/mongodb.repo

yum install -y mongodb-org &>>$LOG_FILE
Stat $? "Install MongoDB Service"
systemctl enable mongod &>>$LOG_FILE
systemctl start mongod &>>$LOG_FILE
Stat $? "Start Mongodb Service  "

cd /tmp
curl -s -L -o /tmp/mongodb.zip curl -s -L -o /tmp/mongodb.zip "https://dev.azure.com/DevOps-Batches/98e5c57f-66c8-4828-acd6-66158ed6ee33/_apis/git/repositories/52feee4a-7c54-4f95-b1f5-2051a56b9d76/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true" &>>$LOG_FILE


Stat $? "Download Mongodb Schema"

unzip -o /tmp/mongodb.zip &>>$LOG_FILE
Stat $? "Extract Mongodb Schema "

mongo < catalogue.js &>>$LOG_FILE
Stat $? "Load Catalogue Schema  "

mongo < users.js &>>$LOG_FILE
Stat $? "Load User Schema\t"
}


MySQL() { 
    yum list installed | grep mysql-community-server &>/dev/null
    case $? in 
       0) 
         true
         ;;
       *) 
    Heading "Installing MySQL Service"
    curl -L -o /tmp/mysql-5.7.28-1.el7.x86_64.rpm-bundle.tar https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.28-1.el7.x86_64.rpm-bundle.tar &>>$LOG_FILE
    Stat $? "Download MySQL Bundle \t"

    cd /tmp
    tar -xf mysql-5.7.28-1.el7.x86_64.rpm-bundle.tar 
    Stat $? "Extract MySQL Bundle \t"

    yum remove mariadb-libs -y &>>$LOG_FILE
    yum install mysql-community-client-5.7.28-1.el7.x86_64.rpm mysql-community-common-5.7.28-1.el7.x86_64.rpm mysql-community-libs-5.7.28-1.el7.x86_64.rpm mysql-community-server-5.7.28-1.el7.x86_64.rpm -y &>>$LOG_FILE
    
    Stat $? "Install MySQL Database\t"
    ;;
esac

    systemctl enable mysqld &>>$LOG_FILE
    systemctl start mysqld &>>$LOG_FILE
    Stat $? "Start MySQL Server\t"

    sleep 20

    DEFAULT_PASSWORD=$(cat /var/log/mysqld.log | grep 'A temporary password'| awk '{print $NF}' )
    echo -e "[client ]\nuser=root\npassword=$DEFAULT_PASSWORD" >/root/.mysql-default

    echo -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyRootPass@1';\nuninstall plugin 
    validate_password;\nALTER USER 'root'@'localhost' IDENTIFIED BY 'password';" >/tmp/remove-plugin.sql 

    mysql --defaults-extra-file=/root/.mysql-default --connect-expired-password </tmp/remove-plugin.sql &>>$LOG_FILE
    Stat $? "Reset MySQL Password\t"

    curl -s -L -o /tmp/mysql.zip "https://dev.azure.com/DevOps-Batches/98e5c57f-66c8-4828-acd6-66158ed6ee33/_apis/git/repositories/0a5a6ec5-35c7-4939-8ace-7c274f080347/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true" mysqld &>>$LOG_FILE
    Stat $? "Download MySQL Schema"

    cd /tmp
    unzip -o /tmp/mysql.zip &>>$LOG_FILE
    Stat $? "Download MySQL Schema"

    mysql -uroot -ppassword <shipping.sql
    mysql -uroot -ppassword <ratings.sql
    Stat $? "Load Schema to MySQL"   

}


RabbitMQ() {
    Heading "Installing RabbitMQ Service"

    yum list installed | grep esl-erlang &>/dev/null

    if [$? -ne 0]; then
    yum install https://packages.erlang-solutions.com/erlang/rpm/centos/7/x86_64/esl-erlang_22.2.1-1~centos~7_amd64.rpm -y &>>$LOG_FILE
    Stat $? "Install ErLang \t"   
    fi


    curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>$LOG_FILE
    Stat $? "Setup RabbitMQ Repos \t"   

    yum install rabbitmq-server -y &>>$LOG_FILE
    Stat $? "Install RabbitMQ Server \t"

    systemctl enable rabbitmq-server &>>$LOG_FILE
    systemctl start rabbitmq-server &>>$LOG_FILE
    Stat $? "Start RabbitMQ Server \t"  
}


Redis() { 
    Heading "Installing Redis Service"

    yum install epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>$LOG_FILE
    Stat $? "Install Yum Utils\t"
    
    yum-config-manager --enable remi &>>$LOG_FILE
    yum install redis -y &>>$LOG_FILE
    Stat $? "Install Redis Server\t"

    systemctl enable redis &>>$LOG_FILE
    systemctl start redis  &>>$LOG_FILE
    Stat $? "Start Redis Server\t"

}
NODEJS_SETUP(){
    APP_NAME=$1
    yum install nodejs gcc-c++ -y &>>$LOG_FILE
    Stat $? "Install NodeJS\t\t"
    APP_USER_SETUP
    Stat $? "Set up App User\t\t"
     curl -s -L -o /tmp/$APP_NAME.zip "$2" &>>LOG_FILE
    Stat $? "Download Application Archive \t"
    mkdir -p /home/roboshop/$APP_NAME
    cd /home/roboshop/$APP_NAME
    unzip -o /tmp/$APP_NAME.zip &>>$LOG_FILE 
        Stat $? "Extract Application Archive\t"

    npm --unsafe-perm install &>>$LOG_FILE
        Stat $? "Install NodeJS Dependencies\t"


    SETUP_PERMISSIONS
    SETUP_SERVICE $APP_NAME "/bin/node $APP_NAME.js"

}

APP_USER_SETUP(){
    id $APP_USER &>/dev/null
    if [ $? -ne 0 ]; then
    useradd $APP_USER
    fi
}


SETUP_PERMISSIONS(){
    chown $APP_USER:$APP_USER /home/$APP_USER -R
}

SETUP_SERVICE(){
    echo "[Unit]
Description = $1 Service File
After = network.target

[Service]
User=$APP_USER
WorkingDirectory=/home/$APP_USER/$1
ExecStart = $2

[Install]
WantedBy = multi-user.target" >/etc/systemd/system/$1.service


systemctl daemon-reload 
systemctl enable $1 &>>$LOG_FILE
systemctl restart $1
Stat $? "Start $1 Service\t\t"



}

Cart() {
    Heading "Installing Cart Service"
    NODEJS_SETUP cart "https://dev.azure.com/DevOps-Batches/98e5c57f-66c8-4828-acd6-66158ed6ee33/_apis/git/repositories/5ad6ea2d-d96c-4947-be94-9e0c84fc60c1/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
    
}

Catalogue() {
    Heading "Installing Catalogue Service"
    NODEJS_SETUP catalogue "https://dev.azure.com/DevOps-Batches/98e5c57f-66c8-4828-acd6-66158ed6ee33/_apis/git/repositories/73bf0c1f-1ba6-49fa-ae4e-e1d6df20786f/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
}



User() {
    Heading "Installing User Service"
    NODEJS_SETUP user "https://dev.azure.com/DevOps-Batches/98e5c57f-66c8-4828-acd6-66158ed6ee33/_apis/git/repositories/713e8842-5bdd-4c10-bc8e-f0c9a80d5efa/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"

} 


Shipping() {
    Heading "Installing Shipping Service"
    yum install maven -y &>>$LOG_FILE
    Stat $? "Install Maven\t\t\t"
    APP_USER_SETUP
    curl -s -L -o /tmp/shipping.zip "https://dev.azure.com/DevOps-Batches/98e5c57f-66c8-4828-acd6-66158ed6ee33/_apis/git/repositories/1d2e4e95-b279-4545-a344-f9064f2dc89f/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true" &>>$LOG_FILE
    Stat $? "Download Application Archive\t"

    mkdir -p /home/$APP_USER/shipping 
    cd /home/$APP_USER/shipping 
    unzip -o /tmp/shipping.zip &>>$LOG_FILE
    Stat $? "Extract Application Archive\t"
    mvn clean package &>>$LOG_FILE
    Stat $? "Install Maven Dependencies\t"
    mv target/*dependencies.jar shipping.jar 
    SETUP_PERMISSIONS
    SETUP_SERVICE shipping "/bin/java -jar shipping.jar"
}

Payment() {
    Heading "Installing Payment Service"
    NODEJS_SETUP
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

APP_USER=roboshop

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

    MySQL)
    MySQL
    ;;

    RabbitMQ)
    RabbitMQ
    ;;   

    Redis)
    Redis
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
        MySQL
        RabbitMQ
        Redis
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




