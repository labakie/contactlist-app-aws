#!/bin/bash

# initial update and packages installation
sudo dnf update -y
sudo dnf install python3 git nginx -y

# clone private git repository using PAT stored in SSM parameter store with AWS managed KMS key
token=$(aws ssm get-parameter --name "/deploy/github_token" --with-decryption --query "Parameter.Value" --output text)
git clone https://$token@github.com/labakie/crud-python-aws.git

# create venv with a same name
cd crud-python-aws
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Nginx reverse proxy
sudo tee /etc/nginx/conf.d/flaskapp.conf > /dev/null << EOF
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
sudo systemctl enable nginx
sudo systemctl start nginx

# setup systemd service
cat << EOF | sudo tee /etc/systemd/system/flaskapp.service > /dev/null
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
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable flaskapp
sudo systemctl start flaskapp
sudo systemctl status flaskapp