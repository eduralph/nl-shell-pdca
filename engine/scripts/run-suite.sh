#!/usr/bin/env bash
# T3 runtime gate — nl-shell's whole pytest suite on the patched worktree.
#
# GATING, unlike the template default (engine/README.md ships whole-suite tiers advisory
# because a pre-existing failure would block every fix). nl-shell's suite has been green
# since its first commit (nl-shell#9), so any red here was introduced by this bundle — and
# the policy gate and sudo passthrough this suite protects are where a regression is
# Critical in the threat model. Demote it to advisory only if the baseline ever goes red.
set -euo pipefail

WT="${PDCA_WORKTREE:?worktree isolation must be on — \$PDCA_WORKTREE must be set}"
ENGINE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PY="$ENGINE/../../.venv/bin/python3"
[ -x "$PY" ] || PY="$(command -v python3)"

cd "$WT"
if [ ! -f pyproject.toml ]; then
  echo "PDCA-UNVERIFIABLE: the target worktree has no pyproject.toml, so there is no suite to run"
  exit 77
fi

echo "== T3: nl-shell suite (python -m pytest, from the worktree root)"
rc=0
pycache="$(mktemp -d)"   # never trust a .pyc another gate left behind (see run-verify.sh)
PYTHONPYCACHEPREFIX="$pycache" "$PY" -m pytest -p no:cacheprovider -q 2>&1 || rc=$?
rm -rf "$pycache"

case "$rc" in
  0) echo "PDCA-EVIDENCE: T3 PASS — nl-shell suite green" ;;
  5) echo "PDCA-UNVERIFIABLE: pytest collected no tests"; exit 77 ;;
  *) echo "PDCA-EVIDENCE: T3 FAIL — nl-shell suite red (pytest exit $rc)"; exit "$rc" ;;
esac
