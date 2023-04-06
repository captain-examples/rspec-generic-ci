#!/bin/bash
set -euo pipefail

script_path="$(dirname -- "${0}")"

"${script_path}/download-captain.sh"

# shellcheck source=set-captain-env-from-git.sh
source "${script_path}/set-captain-env-from-git.sh"

export CAPTAIN_SUITE_ID=captain-examples-rspec

test_files=$(
  captain partition \
    --index "$CAPTAIN_PARTITION_INDEX" \
    --total "$CAPTAIN_PARTITION_TOTAL" \
    "spec/**/*_spec.rb"
)

captain run -- "$test_files"
