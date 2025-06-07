
# #######################################
# Kubernetes Master Node Initialization # 
# #######################################

# Pull all required Kubernetes control plane images to the node before initializing the cluster.
sudo kubeadm config images pull

# Initialize the Kubernetes control plane (master node).
# This sets up the cluster, generates certificates, and starts the control plane components.
sudo kubeadm init

# Create the .kube directory in the user's home if it doesn't exist.
# This directory will store the kubeconfig file for kubectl access.
mkdir -p "$HOME"/.kube

# Copy the admin kubeconfig file to the user's .kube directory for kubectl authentication.
sudo cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config

# Change ownership of the kubeconfig file to the current user so kubectl can access it without sudo.
sudo chown "$(id -u)":"$(id -g)" "$HOME"/.kube/config

###########################################
# Token creation for joining worker nodes #
###########################################
# Generate and display the kubeadm join command for worker nodes.
# Use this command on each worker node to join them to the cluster. save it for later use.
kubeadm token create --print-join-command


#########################
# Calico Network plugin #
#########################
# Install the Calico network plugin, which provides networking for pods in the cluster.
# Calico is a popular choice for Kubernetes networking and network policy enforcement.
# The Calico manifest is applied to set up the necessary components in the cluster.
# This is required for pod-to-pod communication.

kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/calico.yaml

############################
# NGINX Ingress Controller #
############################
# The NGINX Ingress Controller is used to manage external access to services in the cluster.
# It allows routing of external HTTP/S traffic to the appropriate services based on rules.


# Install the NGINX Ingress Controller using the provided manifest.
# This manifest sets up the necessary components for the Ingress Controller in a bare-metal environment.
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.49.0/deploy/static/provider/baremetal/deploy.yaml

############################################
# Shopify kubeaudit installation and usage #
############################################
# This section installs kubeaudit, a tool for auditing Kubernetes clusters for security best practices.
# It is an open-source security auditing tool for Kubernetes developed by Shopify.
# It scans your Kubernetes cluster and resources for common security issues and best practices (like privilege escalation, missing resource limits, etc.).

# Install wget if not already installed
sudo apt-get install -y wget
# Download the kubeaudit binary from the official GitHub releases page.
wget https://github.com/Shopify/kubeaudit/releases/download/v0.21.0/kubeaudit_linux_amd64.tar.gz
# Unpack the downloaded tar.gz file to extract the kubeaudit binary.
tar -xvzf kubeaudit_linux_amd64.tar.gz
# Moves the kubeaudit binary to /usr/local/bin so it can be run from anywhere.
sudo mv kubeaudit /usr/local/bin/
# Runs kubeaudit against your current Kubernetes context and audits for all supported security checks.
kubeaudit all
