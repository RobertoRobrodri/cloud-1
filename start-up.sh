#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
# Update package list and install dependencies
apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    build-essential >> logs.txt

# Install Docker
install -m 0755 -d /etc/apt/keyrings >> logs.txt
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc >> logs.txt
chmod a+r /etc/apt/keyrings/docker.asc >> logs.txt

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null >> logs.txt

apt-get update >> logs.txt
apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin >> logs.txt

# Start Docker service
systemctl start docker >> logs.txt
systemctl enable docker >> logs.txt

# Install Docker Compose
DOCKER_COMPOSE_VERSION="2.3.3"
curl -L "https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose >> logs.txt
chmod +x /usr/local/bin/docker-compose >> logs.txt

# Copy files from Google Cloud Storage bucket
gsutil -m cp -r gs://inception-ply-platform-353b/ . >> logs.txt

# Change directory to the copied files location
cd inception-ply-platform-353b/ >> logs.txt

# # Run make command
make >> logs.txt