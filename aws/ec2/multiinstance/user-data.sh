#!/bin/bash
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl start httpd
echo "This is my web page" > /var/www/html/index.html
