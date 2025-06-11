# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Give permissions to the Docker socket
# This is necessary for the SonarQube container to run properly
# Note: This is not recommended for production environments due to security risks
sudo chmod 666 /var/run/docker.sock

# Create docker container for Nexus Repository Manager
# Note: The Nexus container will run on port 8081
# You can access it via http://<your-server-ip>:8081
# If you want to run it on a different port, change the -p option accordingly
docker run -d --name nexus -p 8081:8081 sonatype/nexus3
# Or this alternative command to ensure it restarts unless stopped
docker run -d --restart unless-stopped --name nexus -p 8081:8081 sonatype/nexus3
