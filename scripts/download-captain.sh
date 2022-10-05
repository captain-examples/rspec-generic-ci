#!/bin/bash
set -euo pipefail

# download & install captain
arch=x86_64 # Supported values are x86_64 or aarch64
os=linux    # Supported values are linux or darwin
tmp="$(mktemp -d)/captain" &&
  curl -o "$tmp" -fsSL "https://releases.captain.build/v1/$os/$arch/captain" &&
  sudo install "$tmp" /usr/local/bin &&
  rm "$tmp" &&
  captain --version
