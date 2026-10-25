"""Doctor check: every dependency in nl-shell's pyproject.toml is installed in this .venv.

The twin of install-target-deps.sh: it reads the same list (runtime `dependencies` plus the
`dev` extra) from the sibling checkout, so a dependency nl-shell adds is checked without
editing pdca.toml. Exits 0 when each requirement is installed at a satisfying version;
otherwise prints the unmet ones and exits 1.

Usage: .venv/bin/python3 engine/scripts/check-target-deps.py [path/to/pyproject.toml]
"""

from __future__ import annotations

import os
import sys
import tomllib
from importlib import metadata
from pathlib import Path

try:
    from packaging.requirements import Requirement
except ImportError:  # pip vendors packaging; every .venv has pip
    from pip._vendor.packaging.requirements import Requirement


def main(argv: list[str]) -> int:
    here = Path(__file__).resolve().parents[2]
    target = Path(os.environ.get("PDCA_TARGET_CHECKOUT", here.parent / "nl-shell"))
    pyproject = Path(argv[1]) if len(argv) > 1 else target / "pyproject.toml"
    project = tomllib.loads(pyproject.read_text(encoding="utf-8"))["project"]
    wanted = project.get("dependencies", []) + project.get(
        "optional-dependencies", {}
    ).get("dev", [])

    unmet = []
    for spec in wanted:
        req = Requirement(spec)
        if req.marker is not None and not req.marker.evaluate():
            continue
        try:
            version = metadata.version(req.name)
        except metadata.PackageNotFoundError:
            unmet.append(f"{spec} (not installed)")
            continue
        if req.specifier and not req.specifier.contains(version, prereleases=True):
            unmet.append(f"{spec} (installed {version})")

    if unmet:
        print(f"unmet nl-shell dependencies from {pyproject}: " + "; ".join(unmet))
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
