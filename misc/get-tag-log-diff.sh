#!/usr/bin/env bash
#
# Copyright © 2020 Barracuda Networks, Inc. All rights reserved.
#

# Set error handling
set -euo pipefail

# Ensure git is updated
git fetch --tags 1>/dev/null

# Get latest 2 tags
mapfile -t GIT_TAGS_LATEST < <(git tag --sort=-committerdate | head -2)

echo -e "${GIT_TAGS_LATEST[1]}...${GIT_TAGS_LATEST[0]}:"

git log --pretty=format:"- %h: %s" "${GIT_TAGS_LATEST[1]}"..."${GIT_TAGS_LATEST[0]}" \
    | grep -v "Merge pull request" | grep -v "Merge branch 'main'"
