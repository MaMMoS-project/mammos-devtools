"""Sync the shared MaMMoS contribution guide into package repositories."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parent
SOURCE = ROOT / "CONTRIBUTING-MaMMoS.md"
PACKAGE_NAMES = [
    "mammos",
    "mammos-ai",
    "mammos-analysis",
    "mammos-dft",
    "mammos-entity",
    "mammos-mumag",
    "mammos-spindynamics",
    "mammos-units",
]


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Copy or check CONTRIBUTING-MaMMoS.md in package repositories."
    )
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--write", action="store_true", help="write package copies")
    mode.add_argument("--check", action="store_true", help="check package copies")
    return parser.parse_args()


def check_targets(source_content: bytes) -> int:
    failed = False
    for package_name in PACKAGE_NAMES:
        target = ROOT / "packages" / package_name / "CONTRIBUTING-MaMMoS.md"
        if not target.exists():
            print(f"missing: {target}", file=sys.stderr)
            failed = True
        elif target.read_bytes() != source_content:
            print(f"stale: {target}", file=sys.stderr)
            failed = True

    if failed:
        print(
            "Run `pixi run sync-contributing` from mammos-devtools.",
            file=sys.stderr,
        )
        return 1

    print("All CONTRIBUTING-MaMMoS.md copies are up to date.")
    return 0


def write_targets(source_content: bytes) -> int:
    for package_name in PACKAGE_NAMES:
        target = ROOT / "packages" / package_name / "CONTRIBUTING-MaMMoS.md"
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(source_content)
        print(f"synced: {target}")
    return 0


def main() -> int:
    args = parse_args()
    source_content = SOURCE.read_bytes()

    if args.check:
        return check_targets(source_content)
    return write_targets(source_content)


if __name__ == "__main__":
    raise SystemExit(main())
