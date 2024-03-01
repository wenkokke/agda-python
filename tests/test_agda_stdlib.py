import agda
import os
import glob
import subprocess
import sys
import pytest  # type: ignore

# Path to Agda standard library:
PACKAGE_ROOT = os.path.join(os.path.dirname(__file__), os.pardir)
STD_LIB_ROOT = os.path.abspath(os.path.join(PACKAGE_ROOT, "vendor", "agda", "std-lib"))

# Known failures for Agda 2.6.3
KNOWN_FAILURES = {
    "2.6.3": [
        "src/Algebra/Operations/Semiring.agda",
        "src/Data/Bin/Properties.agda",
    ]
}


@pytest.mark.parametrize(
    "path",
    [
        relpath
        for relpath in [
            os.path.relpath(path, STD_LIB_ROOT)
            for path in glob.glob(
                os.path.join(STD_LIB_ROOT, "src", "**", "*.agda"), recursive=True
            )
        ]
        if relpath not in KNOWN_FAILURES[agda.VERSION]
    ],
)  # type: ignore
def test_agda_stdlib(path: str) -> None:
    assert 0 == subprocess.check_call(
        [sys.executable, "-m", "agda", path], cwd=STD_LIB_ROOT
    )
