#!/bin/bash
set -euo pipefail

script_path="$(dirname -- "${0}")"

"${script_path}/download-captain.sh"

# shellcheck source=set-captain-env-from-git.sh
source "${script_path}/set-captain-env-from-git.sh"

suite_id="captain-examples-rspec"
test_files=$(
  captain partition \
    --suite-id $suite_id \
    --index "$CAPTAIN_PARTITION_INDEX" \
    --total "$CAPTAIN_PARTITION_TOTAL" \
    "spec/**/*_spec.rb"
)

captain run $suite_id -- $test_files
