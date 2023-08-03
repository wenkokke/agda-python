from typing import List

from .._binding import (
    unsafe_hs_agda_mode_main,
    unsafe_hs_init,
    unsafe_hs_exit,
)


def main(args: List[str]) -> int:
    try:
        unsafe_hs_init(args)
        return unsafe_hs_agda_mode_main()
    finally:
        unsafe_hs_exit()
