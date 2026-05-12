# Contributing to mammos-devtools

`mammos-devtools` is the umbrella development repository for working on the
MaMMoS package suite together. It keeps the package repositories under
`packages/`, but those packages remain standalone Git repositories.

For shared MaMMoS contribution standards, read
[`CONTRIBUTING-MaMMoS.md`](CONTRIBUTING-MaMMoS.md). Package-specific setup and
checks live in each package repository's `CONTRIBUTING.md`.

## Prepare the umbrella checkout

Install the external tools listed in the README, then clone the package
repositories:

```shell
bash prepare.sh
```

This creates `packages/` and clones the MaMMoS package repositories into it.
Each package has its own `.git` directory, branch, status, and pull requests.

To update all package repositories from the umbrella checkout:

```shell
pixi run -e prepare update-repos
```

## Work on packages

The root `pixi.toml` installs packages from `packages/` in editable mode. This
is useful when testing interactions across multiple MaMMoS packages.

Run package-specific tests from the package repository, for example:

```shell
cd packages/mammos-entity
pixi run test-all
pixi run style
```

Only change the package repositories that are needed for the work. A change in
one package does not automatically require matching edits in every package.

## Documentation

Build the shared MaMMoS documentation from the umbrella checkout:

```shell
pixi run docs-build
```

Open the built documentation in a browser:

```shell
pixi run docs-browse
```

Start JupyterLab in the `packages/` directory:

```shell
pixi run examples
```

## Shared contributing guide sync

`CONTRIBUTING-MaMMoS.md` is canonical in this repository and is copied into
package repositories so standalone contributors can read it.

Update package copies:

```shell
pixi run sync-contributing
```

Check that package copies are current:

```shell
pixi run check-contributing
```
