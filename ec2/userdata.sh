#!/bin/bash
sudo apt-get update
sudo apt-get install awscli -y
sudo apt-get install python3-pip -y
pip3 install flask --upgrade
aws s3 cp s3://steven-levine-simpli-safe-interview-test/getip.py .
sudo iptables -I INPUT -p tcp --dport 5000 -j ACCEPT
env FLASK_APP=getip.py python3 -m flask run --host=0.0.0.0 &