#!/bin/bash
chown root:root /home
chmod 755 /home
chown ec2-user:ec2-user /home/ec2-user -R
chmod 700 /home/ec2-user /home/ec2-user/.ssh
chmod 600 /home/ec2-user/.ssh/authorized_keys