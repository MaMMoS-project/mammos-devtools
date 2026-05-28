#!/usr/bin/env bash
set -e

repos=(
    mammos
    mammos-ai
    mammos-analysis
    mammos-dft
    mammos-entity
    mammos-mumag
    mammos-spindynamics
    mammos-units
)

# Clone a repository only if it is not already available locally.
# Existing repositories are left untouched to avoid overwriting local work.
clone_if_missing() {
    local repo="$1"
    local url="git@github.com:MaMMoS-project/${repo}.git"

    if git -C "$repo" rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        echo "$repo already exists, skipping clone"
    elif [ -e "$repo" ]; then
        # Do not try to repair or delete ambiguous directories automatically.
        echo "Error: $repo exists but is not a valid git repository." >&2
        echo "Please inspect or remove packages/$repo and run prepare.sh again." >&2
        return 1
    else
        git clone "$url" "$repo"
    fi
}

mkdir -p packages
cd packages

# Clone all MaMMoS repositories that are not already present in packages/.
for repo in "${repos[@]}"; do
    clone_if_missing "$repo"
done

if (which pre-commit > /dev/null); then
    # Install hooks in every prepared repository.
    for repo in "${repos[@]}"; do
        cd "$repo" && pwd && pre-commit install
        cd ..
    done
else
    echo Warning: could not find pre-commit, skipping 'pre-commit install' in all repositories
fi
