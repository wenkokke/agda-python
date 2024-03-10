from typing import List

from ._binding import (
    unsafe_hs_agda_version,
    unsafe_hs_agda_main,
    unsafe_hs_init,
    unsafe_hs_exit,
)

VERSION: str = "2.6.4.1"


def version() -> str:
    try:
        unsafe_hs_init([])
        return str(unsafe_hs_agda_version())
    finally:
        unsafe_hs_exit()


def main(args: List[str]) -> int:
    try:
        unsafe_hs_init(args)
        return unsafe_hs_agda_main()
    finally:
        unsafe_hs_exit()
