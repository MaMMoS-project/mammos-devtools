#!/usr/bin/env bash
set -e

mkdir -p packages
cd packages
git clone git@github.com:MaMMoS-project/mammos.git
git clone git@github.com:MaMMoS-project/mammos-analysis.git
git clone git@github.com:MaMMoS-project/mammos-dft.git
git clone git@github.com:MaMMoS-project/mammos-entity.git
git clone git@github.com:MaMMoS-project/mammos-mumag.git
git clone git@github.com:MaMMoS-project/mammos-spindynamics.git
git clone git@github.com:MaMMoS-project/mammos-units.git
