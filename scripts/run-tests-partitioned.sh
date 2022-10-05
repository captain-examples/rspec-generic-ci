#!/bin/bash
set -euo pipefail

script_path="$(dirname -- "${0}")"

"${script_path}/download-captain.sh"

# shellcheck source=set-captain-env-from-git.sh
source "${script_path}/set-captain-env-from-git.sh"

suite_id="rspec"
test_files=$(
  captain partition \
    --suite-id $suite_id \
    --index "$CAPTAIN_PARTITION_INDEX" \
    --total "$CAPTAIN_PARTITION_TOTAL" \
    "spec/**/*_spec.rb"
)

captain run \
  --suite-id $suite_id \
  --test-results tmp/rspec.json \
  -- \
  bundle exec rspec \
  --format json --out tmp/rspec.json \
  --format progress \
  "$test_files"