#!/bin/bash
set -euo pipefail

script_path="$(dirname -- "${0}")"

"${script_path}/download-captain.sh"

# shellcheck source=set-captain-env-from-git.sh
source "${script_path}/set-captain-env-from-git.sh"

captain run captain-examples-rspec
