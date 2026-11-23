"""Shared fixtures: utils/ on sys.path, the two ROMs (skipped when missing)."""
import sys
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "utils"))

import kristall_rom as kr  # noqa: E402


@pytest.fixture(scope="session")
def root():
    return ROOT


def _rom(path):
    if not path.exists():
        pytest.skip(f"missing {path}")
    return kr.Rom(path)


@pytest.fixture(scope="session")
def pret_rom():
    return _rom(kr.PRET / "pokecrystal.gbc")


@pytest.fixture(scope="session")
def kristall_rom_file():
    return kr.KRISTALL_ROM


@pytest.fixture(scope="session")
def kristall_rom():
    return _rom(kr.KRISTALL_ROM)


@pytest.fixture(scope="session")
def pairs(tmp_path_factory):
    """pret's texts paired with Kristall's, built once per run into a temp dir (Nintendo text)."""
    if not (kr.PRET / "pokecrystal.gbc").exists() or not kr.KRISTALL_ROM.exists():
        pytest.skip("missing a ROM")
    import kristall_pairs
    out = tmp_path_factory.mktemp("pairs") / "kristall_pairs.json"
    kristall_pairs.write_pairs(kristall_pairs.build_pairs(kr.PRET, kr.KRISTALL_ROM), out)
    return kristall_pairs.load_pairs(out)
