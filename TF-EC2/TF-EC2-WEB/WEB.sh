#!/bin/bash

## Hostname Setting

sudo hostnamectl set-hostname TF-WEB
sleep 1

## Apache Package Install

sudo yum install -y httpd httpd-devel

## Apache Server Startn & Enable

sudo systemctl start httpd && sudo systemctl enable httpd

## Firewalld Disable

sudo systemctl stop firewalld && sudo systemctl disable firewalld
sleep 1
