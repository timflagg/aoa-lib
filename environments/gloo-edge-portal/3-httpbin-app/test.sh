#!/bin/bash

# wait for bookinfo deployment
./tools/wait-for-rollout.sh deployment httpbin httpbin 10