#!/bin/bash

# wait for gloo edge deployment
./tools/wait-for-rollout.sh deployment gloo gloo-system 10
