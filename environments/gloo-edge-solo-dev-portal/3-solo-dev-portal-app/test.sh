#!/bin/bash

./tools/wait-for-rollout.sh deployment petstore-dev petstore 5
./tools/wait-for-rollout.sh deployment petstore-prod petstore 5