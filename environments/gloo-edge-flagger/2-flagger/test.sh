#!/bin/bash

# wait for bookinfo deployment
./tools/wait-for-rollout.sh deployment flagger gloo-system 10