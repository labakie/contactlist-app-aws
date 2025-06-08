#!/bin/bash
# create a log file
exec > /var/log/user-data.log 2>&1
set -x

# initial update and packages installation
dnf update -y
dnf install python3 git nginx -y

# since user-data is executed by root, change from root directory to home directory 
cd /home/ec2-user

# clone private git repository using PAT stored in SSM parameter store with AWS managed KMS key
token=$(aws ssm get-parameter --name "/deploy/github_token" --with-decryption --query "Parameter.Value" --output text)
git clone --branch main https://$token@github.com/labakie/crud-python-aws.git

# change the directory ownership to ec2-user 
chown -R ec2-user:ec2-user /home/ec2-user/crud-python-aws

# enter directory
cd crud-python-aws

# create venv and libraries installation
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Nginx reverse proxy
tee /etc/nginx/conf.d/flaskapp.conf > /dev/null << EOF
server {
    listen 80;
    # server_name yourdomain.com;

    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

# enable and start nginx
systemctl enable nginx
systemctl start nginx

# create service using systemd
cat << EOF | tee /etc/systemd/system/flaskapp.service > /dev/null
[Unit]
Description=Flask Python CRUD Web App using extid
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/crud-python-aws
ExecStart=/home/ec2-user/crud-python-aws/venv/bin/python3 app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# enable service
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable flaskapp
systemctl start flaskapp
systemctl status flaskapp