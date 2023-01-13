#!/bin/bash

# wait for podinfo deployment
./tools/wait-for-rollout.sh deployment podinfo-primary test 10