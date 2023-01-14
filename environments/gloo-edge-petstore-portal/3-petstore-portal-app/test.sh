#!/bin/bash

./tools/wait-for-rollout.sh deployment petstore-v1 default 5
./tools/wait-for-rollout.sh deployment petstore-v2 default 5