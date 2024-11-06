#!/bin/bash
chown root:root /home
chmod 755 /home
chown ubuntu:ubuntu /home/ubuntu -R
chmod 700 /home/ubuntu /home/ubuntu/.ssh
chmod 600 /home/ubuntu/.ssh/authorized_keys
sudo apt-get update
sudo apt-get install -y jq
sudo apt-get install -y openjdk-21-jre-headless