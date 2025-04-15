#!/bin/bash
set -euo pipefail

# bidirectional git sync,
# print latest diff
#
# also works without a remote

# commit
git add .
git commit -m updates &>/dev/null || true

# rebase
git fetch || true
git rebase &>/dev/null || true

# push
git push &>/dev/null || true

# print diff
git --no-pager show --pretty="" HEAD
