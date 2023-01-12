#!/bin/bash
#set -e

export vars_file=$1

# check to see if environment name variable was passed through, if not prompt for it
if [[ ${vars_file} == "" ]]
  then
    # provide vars file
    echo "Please provide the vars file to use (i.e. single-cluster-freestyle-vars.txt):"
    read vars_file
fi

#pushd . > '/dev/null';
#SCRIPT_DIR="${BASH_SOURCE[0]:-$0}";
#
#while [ -h "$SCRIPT_DIR" ];
#do
#    cd "$( dirname -- "$SCRIPT_DIR"; )";
#    SCRIPT_DIR="$( readlink -f -- "$SCRIPT_DIR"; )";
#done
#
#cd "$( dirname -- "$SCRIPT_DIR"; )" > '/dev/null';
SCRIPT_DIR="$( pwd; )/aoa-tools";
#popd  > '/dev/null';

# source vars from root directory vars.txt
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
source $PARENT_DIR/${vars_file} && export $(sed '/^#/d' $PARENT_DIR/${vars_file} | cut -d= -f1)

# check to see if defined contexts exist
if [[ $(kubectl config get-contexts | grep ${cluster_context}) == "" ]] ; then
  echo "Check Failed: ${cluster_context} context does not exist. Please check to see if you have the clusters available"
  echo "Run 'kubectl config get-contexts' to see currently available contexts. If the clusters are available, please make sure that they are named correctly. Default is ${cluster_context}"
  exit 1;
fi

# check to see if environment overlay variable was passed through, if not prompt for it
if [[ ${environment_overlay} == "" ]]
  then
    # provide environment overlay
    echo "Please provide the environment overlay to use (i.e. prod, dev):"
    read environment_overlay
fi

# install argocd
cd $SCRIPT_DIR/bootstrap-argocd
if [ "${environment_overlay}" == "ocp" ] ; then 
     ./install-argocd.sh insecure-rootpath-ocp ${cluster_context}
  else
     ./install-argocd.sh insecure-rootpath ${cluster_context}
  fi
cd $SCRIPT_DIR

# wait for argo cluster rollout
$SCRIPT_DIR/tools/wait-for-rollout.sh deployment argocd-server argocd 20 ${cluster_context}

# deploy app of app waves
for i in $(ls $PARENT_DIR/${environment_name} | sort -n); do 
  echo "starting ${i}"
  # run init script if it exists
  [[ -f "$PARENT_DIR/${environment_name}/${i}/init.sh" ]] && $PARENT_DIR/${environment_name}/${i}/init.sh 
  # deploy aoa wave
  $SCRIPT_DIR/tools/configure-wave.sh ${environment_name} ${i} ${environment_overlay} ${cluster_context} ${github_username} ${repo_name} ${target_branch}
  # run test script if it exists
  [[ -f "$PARENT_DIR/${environment_name}/${i}/test.sh" ]] && $PARENT_DIR/${environment_name}/${i}/test.sh
done

echo "END."

