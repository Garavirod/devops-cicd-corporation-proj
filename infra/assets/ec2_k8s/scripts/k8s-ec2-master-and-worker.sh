# Download the latest stable kubectl binary (Kubernetes CLI tool)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Download the SHA256 checksum for the kubectl binary
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# Verify the integrity of the downloaded kubectl binary
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# Install kubectl to /usr/local/bin with root ownership and correct permissions
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Make kubectl executable and move it to the user's local bin for convenience
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl
# Note: You may want to add ~/.local/bin to your PATH for easy access

# Check that kubectl is installed and print its client version
kubectl version --client

# Disable swap, which is required for Kubernetes to function properly
sudo swapoff -a

# Create a config file to ensure required kernel modules are loaded at boot
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

# Load the kernel modules immediately for the current session
sudo modprobe overlay
sudo modprobe br_netfilter

# Set sysctl parameters needed for Kubernetes networking and persist them across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply the sysctl parameters without rebooting
sudo sysctl --system

# --- Install CRI-O Container Runtime ---

# Update package lists and install dependencies for adding repositories and HTTPS support
sudo apt-get update -y
sudo apt-get install -y software-properties-common curl apt-transport-https ca-certificates gpg

# Add the CRI-O repository GPG key for package verification
sudo curl -fsSL https://pkgs.k8s.io/addons:/cri-o:/prerelease:/main/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/cri-o-apt-keyring.gpg

# Add the CRI-O repository to the system's sources list
echo "deb [signed-by=/etc/apt/keyrings/cri-o-apt-keyring.gpg] https://pkgs.k8s.io/addons:/cri-o:/prerelease:/main/deb/ /" | sudo tee /etc/apt/sources.list.d/cri-o.list

# Update package lists and install CRI-O
sudo apt-get update -y
sudo apt-get install -y cri-o

# Reload systemd, enable CRI-O to start on boot, and start the CRI-O service now
sudo systemctl daemon-reload
sudo systemctl enable crio --now
sudo systemctl start crio.service

echo "CRI runtime installed successfully"

# --- Install Kubernetes Components ---

# Add the Kubernetes repository GPG key for package verification
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# Add the Kubernetes repository to the system's sources list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update package lists and install kubelet, kubectl, and kubeadm (version 1.29.x)
sudo apt-get update -y
sudo apt-get install -y kubelet="1.29.0-*" kubectl="1.29.0-*" kubeadm="1.29.0-*"

# Install jq, a lightweight and flexible command-line JSON processor (useful for scripting with Kubernetes)
sudo apt-get update -y
sudo apt-get install -y jq

# Enable kubelet to start on boot and start the kubelet service now
sudo systemctl enable --now kubelet
sudo systemctl start kubelet

