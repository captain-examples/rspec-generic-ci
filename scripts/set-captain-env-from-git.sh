#!/bin/bash
set -euo pipefail

# this script sets captain's env from git if it's available
# it can be used on CI systems that don't have a deeper integration with captain

# note: all of these params are equivalent to captain CLI flags, (e.g. CAPTAIN_WHO is equivalent to --who)
CAPTAIN_WHO=$(git show -s --format='%an <%ae>')
CAPTAIN_SHA=$(git rev-parse HEAD)
# try to find the current branch, and fall back to a branch or tag that the current commit is in
CAPTAIN_BRANCH=$({
  git branch --show-current
  git branch --contains HEAD | grep -v 'HEAD detached' | sed 's/^\* //' | head -n 1
  git tag --contains HEAD | head -n 1
} | head -n 1)
CAPTAIN_COMMIT_MESSAGE=$(git show -s --format='%B')
CAPTAIN_TITLE=$(echo "$CAPTAIN_COMMIT_MESSAGE" | head -n 1)

export CAPTAIN_WHO CAPTAIN_SHA CAPTAIN_BRANCH CAPTAIN_COMMIT_MESSAGE CAPTAIN_TITLE
