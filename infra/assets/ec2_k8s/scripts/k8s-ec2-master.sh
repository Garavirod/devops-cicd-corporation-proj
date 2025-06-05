 sudo kubeadm config images pull

 sudo kubeadm init

 mkdir -p "$HOME"/.kube
 sudo cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config
 sudo chown "$(id -u)":"$(id -g)" "$HOME"/.kube/config

 # Network Plugin = calico
 kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/calico.yaml


# Generate the join command for worker nodes
 kubeadm token create --print-join-command > /tmp/k8s-worker-join.sh

 # Copy the join command to the home directory
 cp /tmp/k8s-worker-join.sh "$HOME"/k8s-worker-join.sh

 # Set permissions for the join command script
 chmod 755 "$HOME"/k8s-worker-join.sh

 echo "Kubernetes master node setup completed successfully."
 echo "Join command for worker nodes is available at $HOME/k8s-worker-join.sh"
