# mammos-devtools

This repository provides utilities to simplify developing MaMMoS.

## Requirements
- bash
- git
- [pixi](https://pixi.sh/latest/)
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

## Tips

- Sometimes pixi seems to fail to install packages in editable mode even though
  it is configured to do so. Run `pixi list | grep mammos` and check if the last
  column contains `<package-name>...none-any.whl (editable)`. If it does bump
  the version number in `pyproject.toml` of the affected package(s) (does not
  have to be commited) and try again

# Workflow to create a new `mammos-` package

For clarity, let us assume we want to create a mammos framework component for `x`, so the package should be called `mammos-x`.

1. Reserve the name `mammos-x` on PyPI

   - go to `mammos` organisation 
   - create package
   - go to `publishing`
     - `owner` : `MaMMos-project`
     - `repository name` : `mammos-x`
     - `workflow name` : `publish.yml`
     - `enivironment name` : `pypi`
    
2. Create GitHub repository
   - owner: MaMMos-project
   - enter description
   - make it public

3. Install `cookiecutter`

4. Create package

   ```console
   cookiecutter gh:MaMMoS-project/cookiecutter
   ```

   This creates a subdirectory `mammos-x` (not a git repository yet).

5. change into the subdirecotry and create a git repository:

   ```console
   cd mammos-x
   git init .
   ```

6. Add git remote (as suggested by github in step 2):

   ```console
   git remote add origin git@github.com:MaMMoS-project/mammos-x.git
   ```

7. Activate pre-commits in the new repository:

   ```console
   pre-commit install
   ```

8. Search for `TODO` strings in the files, and work through them.

9. Commit updated files with `git add . && git commit`.

