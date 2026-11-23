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


@pytest.fixture(scope="session")
def base():
    """The last merged Upstream commit: Upstream's English."""
    import subprocess
    out = subprocess.run(["git", "-C", str(ROOT), "merge-base", "HEAD", "upstream/master"],
                         capture_output=True, text=True)
    if out.returncode:
        pytest.skip("no upstream/master")
    return out.stdout.strip()


@pytest.fixture
def git_repo(tmp_path):
    """A factory: git_repo(base_files, head_files) -> a repo with a `base` tag and a head commit."""
    import subprocess

    def make(base_files, head_files):
        def git(*args):
            subprocess.run(["git", "-C", str(tmp_path), *args], check=True, capture_output=True)
        git("init", "-q")
        git("config", "user.email", "test@example.invalid")
        git("config", "user.name", "test")
        for files, message in ((base_files, "base"), (head_files, "head")):
            for rel, text in files.items():
                path = tmp_path / rel
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text(text)
            git("add", "-A")
            git("commit", "-q", "--allow-empty", "-m", message)
            if message == "base":
                git("tag", "base")
        return tmp_path
    return make
