#!/bin/bash

./tools/wait-for-rollout.sh deployment petstore-dev petstore 20
./tools/wait-for-rollout.sh deployment petstore-prod petstore 20