#!/bin/bash
sudo apt update -y
sudo apt install default-jre
sudo apt install docker.io -y
sudo git clone git@github.com:spring-projects/spring-petclinic.git
cd spring-petclinic
./mvnw package
java -jar target/*.jar