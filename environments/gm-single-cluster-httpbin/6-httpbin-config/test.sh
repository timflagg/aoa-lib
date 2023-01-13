#!/bin/bash

echo 
echo "installation complete:"
echo
echo "To access argocd dashboard, follow the methods below:"
echo 
echo "Method 1: modify /etc/hosts on your local machine (this will require sudo privileges)"
echo "cat <<EOF | sudo tee -a /etc/hosts"
echo "$(kubectl -n gloo-system get service gateway-proxy -o jsonpath='{.status.loadBalancer.ingress[0].ip}') argocd-local.glootest.com gmui-local.glootest.com httpbin-local.glootest.com"
echo "EOF"
echo
echo "access argocd at https://argocd-local.glootest.com/argo"
echo "access Gloo Mesh UI at https://gmui-local.glootest.com"
echo "access the httpbin application at: https://httpbin-local.glootest.com/get"
echo
echo "Method 2: use port-forwarding"
echo "alternatively, access argocd using port-forward command:" 
echo "kubectl port-forward svc/argocd-server -n argocd 9999:443"
echo
echo "argocd credentials:"
echo "user: admin"
echo "password: solo.io"
echo
echo "access argocd at https://localhost:9999/argo"
echo 
echo
echo "access gloo mesh ui using port-forward command:" 
echo "kubectl port-forward -n gloo-mesh svc/gloo-mesh-ui 8090 --context mgmt"
echo
echo "access gloo mesh ui at https://localhost:8090"
echo 