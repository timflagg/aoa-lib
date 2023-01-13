#!/bin/bash

# wait for bookinfo deployment
./tools/wait-for-rollout.sh deployment productpage-v1 bookinfo-v1 10
./tools/wait-for-rollout.sh deployment productpage-v1 bookinfo-v2 10