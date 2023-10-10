#!/bin/bash

## Hostname Setting

sudo hostnamectl set-hostname TF-WAS
sleep 1

## Apache Package Install

sudo yum install -y tomcat

## Apache Server Startn & Enable

sudo systemctl start tomcat && sudo systemctl enable tomcat


## Firewalld Disable

sudo systemctl stop firewalld && sudo systemctl disable firewalld
sleep 1

