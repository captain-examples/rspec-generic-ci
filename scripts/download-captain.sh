#!/bin/bash
set -euo pipefail

# download & install captain
tmp="$(mktemp -d)/captain" &&
  curl -o "$tmp" -fsSL "https://releases.captain.build/v1/linux/x86_64/captain" &&
  sudo install "$tmp" /usr/local/bin &&
  rm "$tmp" &&
  captain --version
