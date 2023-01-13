#!/bin/bash

# wait for gloo portal deployment
./tools/wait-for-rollout.sh deployment gloo-portal-controller gloo-portal 5
./tools/wait-for-rollout.sh deployment gloo-portal-admin-server gloo-portal 5
