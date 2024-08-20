# Contributing to Agda for Python

## Update the Agda version

- [ ] Change the tag of the Git submodule at `vendor/agda`:

  ```bash
  cd vendor/agda
  git fetch
  git checkout v2.7.0
  ```

- [ ] Change the version bound in `Agda-Python.cabal`:

  ```diff
  foreign-library _binding
  ...
  build-depends:
  -  , Agda       ==2.6.4.3
  +  , Agda       ==2.7.0
     ...
  ```

- [ ] Change the version in `pyproject.toml`:

  ```diff
    [project]
    name = "agda"
  - version = "2.6.4.3"
  + version = "2.7.0"
  ```

- [ ] Change the version in `src/agda/__init__.py`:

  ```diff
  - VERSION: str = "2.6.4.3"
  + VERSION: str = "2.7.0"
  ```

- [ ] Change the version in the preceding steps.

## Update the GHC version

Updating the version for the macOS and Windows builds is easy, and only requires changing the default GHC and Cabal versions as listed in `ci.yml`.

- [ ] Change the values of `DEFAULT_GHC_VERSION` and `DEFAULT_CABAL_VERSION` in `.github/workflows/ci.yml`:

  ```diff
    env:
  -   DEFAULT_GHC_VERSION: "9.4.8"
  -   DEFAULT_CABAL_VERSION: "3.10.2.1"
  +   DEFAULT_GHC_VERSION: "9.6.5"
  +   DEFAULT_CABAL_VERSION: "3.10.3.0"
  ```

The Python wheels for Linux are built using the [wenkokke/manylinux_ghc] images, which are copies of the [pypa/manylinux] images with GHC preinstalled.
If no `manylinux_ghc` images exist for the GHC version you wish to use, you will have to file a PR to  the [wenkokke/manylinux_ghc] to add these versions, and wait for them to be published to DockerHub.

- [ ] Change the images set in `pyproject.toml`:

  ```diff
    [tool.cibuildwheel]
  - manylinux-x86_64-image = "wenkokke  manylinux_2_28_ghc948_x86_64"
  - musllinux-x86_64-image = "wenkokke  musllinux_1_1_ghc948_x86_64"
  + manylinux-x86_64-image = "wenkokke  manylinux_2_28_ghc965_x86_64"
  + musllinux-x86_64-image = "wenkokke  musllinux_1_1_ghc965_x86_64"
  ```

## Add or remove a Python version

- [ ] Change the `requires-python` version range in `pyproject.toml`:

  ```diff
  - requires-python = ">=3.7.1,<3.12"
  + requires-python = ">=3.7.1,<3.13"
  ```

- [ ] Add the classifier for the new Python version in `pyproject.toml`:

  ```diff
    classifiers = [
      ...
      "Programming Language :: Python :: 3.7",
      "Programming Language :: Python :: 3.8",
      "Programming Language :: Python :: 3.9",
      "Programming Language :: Python :: 3.10",
      "Programming Language :: Python :: 3.11",
  +   "Programming Language :: Python :: 3.12",
      ...
    ]
  ```

- [ ] Add the Python version to the Tox testing matrix in `pyproject.toml`:

  ```diff
    [tool.tox]
    legacy_tox_ini = """
    [tox]
    min_version = 4
  - env_list = py{37,38,39,310,311}-{lin,mac, win}
  + env_list = py{37,38,39,310,311,312}-{lin,mac, win}
  
  - [testenv:py{37,38,39,310,311}-{lin,mac,win}]
  + [testenv:py{37,38,39,310,311,312}-{lin,mac,win}]
    package = external
    package_env = build-{env_name}
    platform =
      lin: linux
      mac: darwin
      win: win32
    extras =
      test
    commands =
      {env_python} -m pytest {posargs}
    
  - [testenv:build-py{37,38,39,310,311}-{lin,mac,win}]
  + [testenv:build-py{37,38,39,310,311,312}-{lin,mac,win}]
    deps =
      build
      auditwheel; sys_platform == 'linux'
      delocate; sys_platform == 'darwin'
    set_env =
      env_python = {env_python}
      package_root = {package_root}
      dist_dir = {package_root}{/}dist
      dist_tmp_dir = {env_tmp_dir}{/}dist
    package_glob =
      py37-lin: {env:dist_dir}{/}*cp37*manylinux*.whl
      py38-lin: {env:dist_dir}{/}*cp38*manylinux*.whl
      py39-lin: {env:dist_dir}{/}*cp39*manylinux*.whl
      py310-lin: {env:dist_dir}{/}*cp310*manylinux*.whl
      py311-lin: {env:dist_dir}{/}*cp311*manylinux*.whl
  +   py312-lin: {env:dist_dir}{/}*cp312*manylinux*.whl
      py37-mac: {env:dist_dir}{/}*cp37*macosx*.whl
      py38-mac: {env:dist_dir}{/}*cp38*macosx*.whl
      py39-mac: {env:dist_dir}{/}*cp39*macosx*.whl
      py310-mac: {env:dist_dir}{/}*cp310*macosx*.whl
      py311-mac: {env:dist_dir}{/}*cp311*macosx*.whl
  +   py312-mac: {env:dist_dir}{/}*cp312*macosx*.whl
      py37-win: {env:dist_dir}{/}*cp37*win*.whl
      py38-win: {env:dist_dir}{/}*cp38*win*.whl
      py39-win: {env:dist_dir}{/}*cp39*win*.whl
      py310-win: {env:dist_dir}{/}*cp310*win*.whl
      py311-win: {env:dist_dir}{/}*cp311*win*.whl
  +   py312-win: {env:dist_dir}{/}*cp312*win*.whl
    allowlist_externals =
      sh
    commands =
      sh {package_root}/scripts/build-wheel.sh
    """
  ```

- [ ] Change the default Python version in `.github/workflows/ci.yml`:

  ```diff
    env:
      ...
  -   DEFAULT_PYTHON_VERSION: "3.11"
  +   DEFAULT_PYTHON_VERSION: "3.12"
  ```

- [ ] Add the Python version to the CI testing matrix in `.github/workflows/ci.yml`:

  ```diff
    strategy:
      fail-fast: false
      matrix:
        os:
          - type: "ubuntu-latest"
            plat: "manylinux_x86_64"
          - type: "ubuntu-latest"
            plat: "musllinux_x86_64"
          - type: "macos-12"
            plat: "macosx_x86_64"
          - type: "macos-14"
            plat: "macosx_arm64"
          - type: "windows-latest"
            plat: "win_amd64"
        python:
          - tag: "cp37"
          - tag: "cp38"
          - tag: "cp39"
          - tag: "cp310"
          - tag: "cp311"
  +       - tag: "cp312"
        exclude:
          - os:
              type: "macos-14"
              plat: "macosx_arm64"
            python:
              tag: "cp37"
  ```

- [ ] Add the Python version to the top of the `.python-version` file:

  ```diff
  + 3.12
    3.11
    3.10
    3.9
    3.8
    3.7
  ```

## Release a new Agda version

1. Update the Agda version (see [above](#update-the-agda-version)).
2. Wait for the tests to pass on CI.
3. Create and push a new tag named `v<AGDA_VERSION>`.

[wenkokke/manylinux_ghc]: https://github.com/wenkokke/manylinux_ghc
[pypa/manylinux]: https://github.com/pypa/manylinux
