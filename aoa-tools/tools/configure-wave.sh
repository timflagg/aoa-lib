#!/bin/bash
#set -e

env_path=${1:-""}
wave_name=${2:-""}
environment_overlay=${3:-""} # prod, dev, base
cluster_context=${4:-""}
github_username=${5:-""}
repo_name=${6:-""}
target_branch=${7:-""}

## source vars from root directory vars.txt
#SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
#source $SCRIPT_DIR/../../${vars_file}

# check to see if environment name variable was passed through, if not prompt for it
#if [[ ${environment_name} == "" ]]
#  then
#    # provide environment name
#    echo "Please provide the environment name to use (i.e. prod, dev):"
#    read environment_name
#fi

# check to see if wave name variable was passed through, if not prompt for it
if [[ ${wave_name} == "" ]]
  then
    # provide license key
    echo "Please provide the wave name:"
    read wave_name
fi

# check to see if environment overlay variable was passed through, if not prompt for it
if [[ ${environment_overlay} == "" ]]
  then
    # provide environment overlay
    echo "Please provide the environment overlay to use (i.e. prod, dev):"
    read environment_overlay
fi

# check to see if cluster context variable was passed through, if not prompt for it
if [[ ${cluster_context} == "" ]]
  then
    # provide cluster context overlay
    echo "Please provide the cluster context to use (i.e. mgmt, cluster1, cluster2):"
    read cluster_context
fi

# check to see if github_username variable was passed through, if not prompt for it
if [[ ${github_username} == "" ]]
  then
    # provide github_username variable
    echo "Please provide the github_username to use (i.e. ably77):"
    read github_username
fi

# check to see if repo_name variable was passed through, if not prompt for it
if [[ ${repo_name} == "" ]]
  then
    # provide repo_name variable
    echo "Please provide the repo_name to use (i.e. gloo-mesh-aoa):"
    read repo_name
fi

# check to see if target_branch variable was passed through, if not prompt for it
if [[ ${target_branch} == "" ]]
  then
    # provide target_branch variable
    echo "Please provide the target_branch to use (i.e. HEAD):"
    read target_branch
fi

kubectl --context ${cluster_context} apply -f - <<EOF
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: wave-${wave_name}-aoa
  namespace: argocd
  finalizers:
  - resources-finalizer.argocd.argoproj.io
spec:
  project: default
  source:
    repoURL: https://github.com/${github_username}/${repo_name}/
    targetRevision: ${target_branch}
    path: $env_path/${wave_name}/${environment_overlay}/active/
  destination:
    server: https://kubernetes.default.svc
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    retry:
      limit: 2
      backoff:
        duration: 5s
        factor: 2
        maxDuration: 3m0s
EOF