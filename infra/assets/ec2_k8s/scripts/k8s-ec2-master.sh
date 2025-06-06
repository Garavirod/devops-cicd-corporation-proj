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

# Install the Calico network plugin, which provides networking for pods in the cluster.
# This is required for pod-to-pod communication.
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/calico.yaml
# Install the NGINX Ingress Controller, which allows external traffic to access services in the cluster.
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.49.0/deploy/static/provider/baremetal/deploy.yaml

# Generate and display the kubeadm join command for worker nodes.
# Use this command on each worker node to join them to the cluster. save it for later use.
kubeadm token create --print-join-command
