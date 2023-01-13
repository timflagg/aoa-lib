#!/bin/bash

# echo proxy url
echo 
echo "installation complete:"
echo
echo "run the commands below to access argocd dashboard at argocd-local.glootest.com and gloo-portal demo at portal-local.glootest.com"
echo 
echo "cat <<EOF | sudo tee -a /etc/hosts"
echo "$(kubectl -n gloo-system get service gateway-proxy -o jsonpath='{.status.loadBalancer.ingress[0].ip}') bookinfo-local.glotoest.com argocd-local.glootest.com portal-local.glootest.com api-local.example.com"
echo "EOF"
echo
echo "access argocd at http://argocd-local.glootest.com/argo"
echo "alternatively, access argocd using port-forward command: kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo
echo "argocd credentials:"
echo "user: admin"
echo "password: solo.io"
echo 
echo "access the bookinfo application at: https://bookinfo-local.glootest.com/productpage"
echo 
echo "access petstore-portal at https://portal-local.glootest.com"
echo
echo "gloo-portal credentials:"
echo "user: developer1"
echo "password: gloo-portal1"
echo
