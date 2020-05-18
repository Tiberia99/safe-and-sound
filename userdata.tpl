#!/bin/bash 
set -x
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1
echo BEGIN
date '+%Y-%m-%d %H:%M:%S'
start=$SECONDS
sudo apt-get update
sudo apt-get install awscli -y
sudo apt-get install python3-pip -y
pip3 install flask --upgrade
aws s3 cp s3://${user_data_bucket_name}/web.py .
sudo iptables -I INPUT -p tcp --dport 5000 -j ACCEPT
env FLASK_APP=web.py python3 -m flask run --host=0.0.0.0 &
duration=$(( SECONDS - start ))
echo "This run took $duration seconds"
echo END