#!/usr/bin/env bash
# [install].extra_bootstrap: install nl-shell's runtime + dev dependencies into this
# instance's .venv — but NOT nl-shell itself. The gates run the target's tests from a
# patched worktree with `src/` on sys.path (nl-shell's pytest config); an installed copy of
# the package would be a second, stale nl_shell that could shadow the code under test.
#
# Reads ../nl-shell/pyproject.toml (the sibling checkout, [publisher.checkouts] default),
# so a new dependency there is picked up by the next `make install`. Idempotent.
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
target="${PDCA_TARGET_CHECKOUT:-$here/../nl-shell}"
py="$here/.venv/bin/python3"

if [ ! -f "$target/pyproject.toml" ]; then
  echo "install-target-deps: $target/pyproject.toml not found — installing pytest only;" \
       "re-run 'make install' once the target has its pyproject.toml" >&2
  "$py" -m pip install --quiet pytest
  exit 0
fi

mapfile -t deps < <("$py" - "$target/pyproject.toml" <<'PY'
import sys, tomllib
project = tomllib.load(open(sys.argv[1], "rb"))["project"]
for dep in project.get("dependencies", []) + project.get("optional-dependencies", {}).get("dev", []):
    print(dep)
PY
)
echo "install-target-deps: ${deps[*]}"
"$py" -m pip install --quiet "${deps[@]}"
