# How to update for new Agda versions?

## Update the Agda version

To update the Agda version, change the version bound in `Agda-Python.cabal`:

```cabal
foreign-library _binding
  ...
  build-depends:
    , Agda       ==2.6.4.3
    ...
```

Furthmore, update the tag of the `agda` submodule:

```bash
cd vendor/agda
git checkout v<new_version>
```

## Update the GHC version

To update the GHC version used for macOS and Windows builds, change the values of `DEFAULT_GHC_VERSION` and `DEFAULT_CABAL_VERSION` in `ci.yml`:

```yaml
env:
  DEFAULT_GHC_VERSION: "9.4.8"
  DEFAULT_CABAL_VERSION: "3.10.2.1"
```

The Python wheels for Linux are built using the [wenkokke/manylinux_ghc] images, which are copies of the [pypa/manylinux] images with GHC preinstalled.

To update the GHC version used for Linux builds, change the images set in `pyproject.toml`:

```toml
[tool.cibuildwheel]
manylinux-x86_64-image = "wenkokke/manylinux_2_28_ghc948_x86_64"
musllinux-x86_64-image = "wenkokke/musllinux_1_1_ghc948_x86_64"
```

## Update the list of data files

The list of data files is reproduces in the Python package. To update the list, copy the glob patterns from `data-files` in `Agda.cabal` to `pyproject.toml`:

```toml
[tool.setuptools.package-data]
"agda.data" = [
  "..."
]
```

# How to create a new release?

1. Update the Agda version
   - in `build-depends`—see [above](#update-the-agda-version);
   - in `Agda-Python.cabal`;
   - in `pyproject.toml`; and
   - in `src/agda/__init__.py`.
2. Create a new tag `v<new_version>`.

The CI builds wheels for x86_64 architectures and publishes them to PyPI and GitHub Releases.

3. Build wheels for macOS ARM64.

   On macOS with an ARM64 chipset, run:

   ```bash
   pipx run tox
   ```

   The wheels will be built to `dist/`.

4. Build wheels for Linux aarch64.

   On any machine with an ARM64 chipset, run:

   ```bash
   ./scripts/docker-build-wheels.sh
   ```

   The wheels will be built to `dist/`.

5. Check the wheels:

   ```bash
   pipx run twine check --strict dist/*.whl
   ```

6. Upload the wheels:

   ```bash
   pipx run twine upload dist/*.whl
   ```

[wenkokke/manylinux_ghc]: https://github.com/wenkokke/manylinux_ghc
[pypa/manylinux]: https://github.com/pypa/manylinux
