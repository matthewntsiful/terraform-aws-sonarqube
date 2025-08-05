#!/bin/bash
set -e

echo "Starting manual setup at $(date)"

# Update system
echo "Updating system packages"
sudo apt update
sudo apt upgrade -y

# Install Docker
echo "Installing Docker"
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu

# Install Docker Compose
echo "Installing Docker Compose"
sudo curl -L "https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Create SonarQube Docker Compose file
echo "Creating SonarQube Docker Compose file"
cat > /home/ubuntu/docker-compose.yml << 'EOF'
version: '3.8'
services:
  sonarqube:
    image: sonarqube:lts-community
    container_name: sonarqube
    restart: unless-stopped
    ports:
      - "9000:9000"
    environment:
      - SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true
    volumes:
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_extensions:/opt/sonarqube/extensions
      - sonarqube_logs:/opt/sonarqube/logs

volumes:
  sonarqube_data:
  sonarqube_extensions:
  sonarqube_logs:
EOF

# Start SonarQube
echo "Starting SonarQube container"
cd /home/ubuntu
sudo docker-compose up -d

echo "Waiting for SonarQube to start..."
sleep 30

# Check status
echo "Docker status:"
sudo docker ps

echo "SonarQube logs:"
sudo docker logs sonarqube

# Change SSH port to 69 (do this last)
echo "Changing SSH port to 69"
sudo sed -i 's/^#Port 22/Port 69/' /etc/ssh/sshd_config
sudo sed -i 's/^Port 22/Port 69/' /etc/ssh/sshd_config
sudo systemctl restart ssh

echo "Setup completed at $(date)"
echo "You can now SSH on port 69 and access SonarQube on port 9000"