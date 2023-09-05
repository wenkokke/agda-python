![The official Agda logo](https://github.com/agda/agda/blob/25cf6745e5ada6c29dd3caeeeb32bae1ee0abb88/doc/user-manual/agda.svg?raw=true)

[![GitHub Workflow Status](https://github.com/wenkokke/agda-python/actions/workflows/ci.yml/badge.svg)](https://github.com/wenkokke/agda-python/actions/workflows/ci.yml) [![PyPI](https://img.shields.io/pypi/v/agda)](https://pypi.org/project/agda/) [![Hackage](https://img.shields.io/hackage/v/Agda)](https://hackage.haskell.org/package/Agda) ![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/wenkokke/agda-python) [![PyPI - Python Version](https://img.shields.io/pypi/pyversions/agda)](https://pypi.org/project/agda/) [![PyPI - Implementation](https://img.shields.io/pypi/implementation/agda)](https://pypi.org/project/agda/)

# Agda Python Distribution

A project that packages Agda as a Python package, which allows you to install Agda from PyPI:

```bash
pip install agda
```

The PyPI package versions follow the [PvP] version numbers of Agda releases, with post-release versions (_e.g._, `v2.6.3.post1`) for patches and non-breaking changes to the documentation and packaging.

Binary wheels are provided for the following platforms:

| Platform | Release    | Architecture |
| -------- | ---------- | ------------ |
| macOS    | ≥10.10     | x86_64       |
|          | ≥13.0      | ARM64        |
| Linux    | libc ≥2.17 | x86_64       |
|          | libc ≥2.28 | aarch64      |
|          | musl ≥1.1  | x86_64       |
| Windows  |            | AMD64        |

The availability of binary wheels is largely determined by the availability of GHC binaries.

For more information, see:

- [The Agda Source Code]
- [The Agda User Manual]

[PvP]: https://pvp.haskell.org
[The Agda Source Code]: https://github.com/agda/agda#readme
[The Agda User Manual]: https://agda.readthedocs.io/en/v2.6.3/
