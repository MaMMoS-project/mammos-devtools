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

