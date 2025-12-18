#!/usr/bin/env bash
set -e

mkdir -p packages
cd packages
git clone git@github.com:MaMMoS-project/mammos.git
git clone git@github.com:MaMMoS-project/mammos-ai.git
git clone git@github.com:MaMMoS-project/mammos-analysis.git
git clone git@github.com:MaMMoS-project/mammos-dft.git
git clone git@github.com:MaMMoS-project/mammos-entity.git
git clone git@github.com:MaMMoS-project/mammos-mumag.git
git clone git@github.com:MaMMoS-project/mammos-spindynamics.git
git clone git@github.com:MaMMoS-project/mammos-units.git

if (which pre-commit > /dev/null); then
    cd mammos && pwd && pre-commit install; cd ..
    cd mammos-ai && pwd && pre-commit install; cd ..
    cd mammos-analysis && pwd && pre-commit install; cd ..
    cd mammos-dft && pwd && pre-commit install; cd ..
    cd mammos-entity && pwd && pre-commit install; cd ..
    cd mammos-mumag && pwd && pre-commit install; cd ..
    cd mammos-spindynamics && pwd && pre-commit install; cd ..
    cd mammos-units && pwd && pre-commit install; cd ..
else
    echo Warning: could not find pre-commit, skipping 'pre-commit install' in all repositories
fi
