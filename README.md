# mammos-devtools

This repository provides utilities to simplify developing MaMMoS.

## Requirements
- bash
- git
- [pixi](https://pixi.sh/latest/), at least version 0.50.2 (older versions have a bug breaking editable installation)
- [pre-commit](https://pre-commit.com/) (optional, but highly recommended;
  install e.g. with your package manager or [pipx](https://pipx.pypa.io/latest/installation/))
- an SSH key connected to your github account to clone repositories via SSH
  (done by default in the `prepare.sh` script)

## Preparation

To clone all mammos software suite repositories into a new subdirectory
`packages` run:
```shell
bash prepare.sh
```

Note: this cannot be done with pixi because the default pixi environment
contains requirements dependencies, which will only be available after the
repositories have been cloned. Pixi tries to resolve these in the `prepare`
environment even though it is configured such that it does not use the default
solve group.


## Available tasks

The following tasks are available to simplify development, execute them with
`pixi run <task>`:

| task         | description                                                                      |
|--------------|----------------------------------------------------------------------------------|
| docs-browse  | Open sphinx documentation in default browser (calls docs-build internally)       |
| docs-build   | Build sphinx documentation using the local version of the packages               |
| docs-clean   | Remove sphinx output                                                             |
| examples     | Start jupyter lab in the `packages` directory                                    |
| update-repos | In all repositories: switch to `main` and pull latest changes (ignores failures) |

Note: some of the optional dependencies used in the workflows of the metapackage
`mammos` can only be installed on Linux.

# Workflow to create a new `mammos-` package

Prerequisites (must be in PATH):
- [cookiecutter](https://cookiecutter.readthedocs.io/en/stable/installation.html#install-cookiecutter)
- [pre-commit](https://pre-commit.com/#install)
- git

For clarity, let us assume we want to create a mammos framework component for `x`, so the package should be called `mammos-x`.

1. Reserve the name `mammos-x` on PyPI

   - go to `mammos` organisation -> Projects
   - create package
   - go to `manage` new project -> `publishing`
     - `owner` : `MaMMoS-project`
     - `repository name` : `mammos-x`
     - `workflow name` : `publish.yml`
     - `enivironment name` : `pypi`

2. Create GitHub repository
   - owner: MaMMos-project
   - enter description
   - make it public
   - do **not** initialise this repository with anything

3. Create package

   ```console
   cookiecutter gh:MaMMoS-project/cookiecutter
   ```

   This creates a subdirectory `mammos-x` with the template content, and in it initialises an empty git repository, sets the origin to git@github.com:MaMMoS-project/mammos-x.git, and activate pre-commit hooks.

4. Search for `TODO` strings in the files, and work through them.

5. Commit all files with `git add . && git commit -m "Initial commit"`.


# Workflow to publish a new version of one framework package:
1. `cd` into `<repo>` root
2. Pull latest main: `git checkout main && git pull --rebase`
3. [optional] Run tests `pixi run test-all`
4. Update version in `pyproject.toml` and `.binder/environment.yml`
5. [optional] Check that the new changelog highlight looks good: `pixi run towncrier build --draft`
6. Run `towncrier` with `pixi run towncrier build` (use `pixi run ...` instead of being in a `pixi shell` to ensure that the updated version number is used)
7. Confirm remove of changes: type `Y` when asked
8. Towncrier stages the changes it makes, but the updated `pyproject.toml` and `.binder/environment.yml` need to be staged: `git add pyproject.toml .binder/environment.yml`
9. Commit all changes: `git commit -m "Bump version"`
10. [optional] Squash commits
11. Push changes: `git push`
12. Tag `git tag <version>`
13. Push tag `git push origin <version>`

# Workflow to publish the metapackage:
1. `cd` into `mammos` root
2. Pull latest main: `git checkout main && git pull --rebase`
3. Update versions for all dependencies in `pyproject.toml`
4. Run tests with updated dependencies: `pixi run test-all`
5. Update version of metapackage in `pyproject.toml` and `.binder/environment.yml`
6. Run `towncrier` with `pixi run towncrier build` (use `pixi run ...` instead of being in a `pixi shell` to ensure that the updated version number is used)
   - Confirm remove of changes: type `Y` when asked.
   - Keep towncrier's default output if there are not changelog fragments.
7. Update changelog in `docs/source/changelog.rst`
   - Copy and paste (translate md to rst) changes from individual CHANGELOG.md files from the framework components
8. Towncrier stages the changes it makes, but the updated `pyproject.toml`,
   `.binder/environment.yml` and `docs/source/changelog.rst` need to be staged:
   `git add pyproject.toml .binder/environment.yml docs/source/changelog.rst`
9. Commit all changes: `git commit -m "Bump version"`
10. [optional] Squash commits
11. Tag `git tag <version>`
12. Push changes: `git push && git push origin <version>`
