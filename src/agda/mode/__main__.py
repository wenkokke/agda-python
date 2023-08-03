from typing import NoReturn
import os
import agda.mode
import sys


def main() -> NoReturn:
    # The `agda-mode` executable uses the `Agda_datadir` environment variable to find its data files.
    os.environ["Agda_datadir"] = os.path.join(os.path.dirname(__file__), "data")
    sys.exit(agda.mode.main(sys.argv))


if __name__ == "__main__":
    main()
