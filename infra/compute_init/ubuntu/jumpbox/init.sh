#!/bin/bash

# sudo run expected

BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/david-lang/cybr-poc/$BRANCH/"

curl -sSL $BASE_URL/infra/compute_init/ubuntu/common/summon/install.sh | bash
