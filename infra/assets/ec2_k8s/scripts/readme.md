## Steps to run the scripts

1. Run k8s-ec2-master-and-worker.sh script into master and workres.
2. Run k8s-ec2-masetr.sh script into master node only.
3. Run follwing command into Master node only:
   1. `kubeadm token create --print-join-command`
4. Expose 6443 port for worker to connect  Master nodes (Add ingress rule for port 6443 in master and egress rule for 6443)
5. Run follwing command into worker nodes
   1. `sudo kubeadm reset pre-flight checks`
   2. Paste the join command you got from the master node and append --v=5 at the end. Make sure either you are working as sudo user or usesudo before the command
6. run follwing command
   1. `kubectl get nodes`
