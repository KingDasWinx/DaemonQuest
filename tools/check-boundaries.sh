#!/usr/bin/env bash
# Fails if a listed crate declares a normal dependency outside its allowlist.
# A boundary that depends on human discipline is not a boundary.
# Unlisted crates (the apps, which are adapters) are unrestricted.
# Adding a dependency to a listed crate means editing this file, on purpose, in review.
set -euo pipefail

declare -A allowed=(
  [dq-domain]=""          # depends on nothing
  [dq-engine]="dq-domain" # never persistence, services, scheduler, tokio, axum
  [dq-protocol]=""        # never dq-domain: the client sees projections
)

status=0
while read -r pkg deps; do
  [[ -v allowed[$pkg] ]] || continue
  for dep in $deps; do
    if [[ " ${allowed[$pkg]} " != *" $dep "* ]]; then
      echo "boundary violation: $pkg -> $dep (see tools/check-boundaries.sh)"
      status=1
    fi
  done
done < <(cargo metadata --format-version 1 --no-deps --locked |
  jq -r '.packages[] | "\(.name) \([.dependencies[] | select(.kind == null) | .name] | join(" "))"')

exit "$status"
