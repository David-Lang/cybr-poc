#!/bin/bash
set -euo pipefail

branch="main"
account="david-lang"
repo="cybr-poc"

#rm -rf ~/$repo || sleep 0
git clone --depth 1 --branch $branch --single-branch https://github.com/$account/$repo.git $repo/active

