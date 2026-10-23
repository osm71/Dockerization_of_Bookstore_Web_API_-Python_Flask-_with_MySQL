#!/bin/bash
exec > /var/log/user-data.log 2>&1
set -x
dnf update -y
dnf install -y git
sudo dnf install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
newgrp docker
sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m) -o /usr/local/lib/docker/cli-plugins/docker-compose

sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose]

git clone https://${github_token}@${github_repo_url}.git /home/ec2-user/app
cd /home/ec2-user/app

cat <<EOF > .env
MYSQL_ROOT_PASSWORD=${root_password}
MYSQL_DATABASE=bookstore_db
MYSQL_USER=app_user
MYSQL_PASSWORD=${user_password}
EOF

sudo docker-compose up -d