import os
import glob
import subprocess
import sys
import pytest

# Path to Agda standard library:
PACKAGE_ROOT = os.path.join(os.path.dirname(__file__), os.pardir)
STD_LIB_ROOT = os.path.abspath(os.path.join(PACKAGE_ROOT, "vendor", "agda", "std-lib"))


@pytest.mark.parametrize(
    "path",
    [
        os.path.relpath(path, STD_LIB_ROOT)
        for path in glob.glob(
            os.path.join(STD_LIB_ROOT, "src", "**", "*.agda"), recursive=True
        )
    ],
)
def test_agda_stdlib(path: str) -> None:
    assert 0 == subprocess.check_call(
        [sys.executable, "-m", "agda", path], cwd=STD_LIB_ROOT
    )
