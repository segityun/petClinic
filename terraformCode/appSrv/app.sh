#!/bin/bash
sudo apt update -y
sudo apt install default-jdk -y
sudo git clone https://github.com/spring-projects/spring-petclinic
cd spring-petclinic
./mvnw spring-boot:run