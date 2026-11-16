#!/usr/bin/env python3
"""Boot a 3DS title in a sandboxed Azahar, optionally replay an input movie, take screenshots.

Usage: python3 -I vc/playtest.py <title.cxi> --shots 10,20,40 [--movie m.ctm] [--out DIR]

Azahar exits at once on a .cia; extract its game content first (vc/README.md).

Azahar lives in vc/local/azahar/ and runs with HOME=vc/local/azahar-home, so nothing touches
~/Library. The first run creates that sandbox config and enables the RPC server (screenshots).
Screenshots are taken over RPC at the given seconds after launch; ones taken while Azahar is
still booting fail, which is expected. A window opens on screen for the duration of the run.
"""
import argparse
import os
import re
import shutil
import signal
import subprocess
import sys
import time

VC = os.path.dirname(os.path.abspath(__file__))
AZAHAR_DIR = os.path.join(VC, "local", "azahar")
EXE = os.path.join(AZAHAR_DIR, "Azahar.app", "Contents", "MacOS", "azahar")
HOME = os.path.join(VC, "local", "azahar-home")
DATA = os.path.join(HOME, "Library", "Application Support", "Azahar")
CONFIG = os.path.join(DATA, "config", "qt-config.ini")
LOG = os.path.join(DATA, "log", "azahar_log.txt")
SETTINGS = {"enable_rpc_server": "true", "check_for_update_on_start": "false",
            "confirmClose": "false", "firstStart": "false", "volume": "0"}  # volume 0: playtests run muted


def ensure_config():
    if not os.path.exists(CONFIG):  # `-h` makes Azahar write its default config, then exit
        subprocess.run([EXE, "-h"], env=dict(os.environ, HOME=HOME),
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, check=False)
    text = open(CONFIG, encoding="utf-8").read()
    for key, value in SETTINGS.items():
        text = re.sub(rf"(?m)^{key}=.*$", f"{key}={value}", text)
        text = re.sub(rf"(?m)^{key}\\default=.*$", f"{key}\\\\default=false", text)
    open(CONFIG, "w", encoding="utf-8").write(text)


def launch(args, stdout_path):
    """Start Azahar orphaned, so launchd (pid 1) is its parent, and return its pid.

    Azahar blocks on a modal "run via the Azahar.app bundle" warning, before booting the game,
    whenever getppid() != 1. A shell that backgrounds it and exits hands it to launchd.
    """
    r = subprocess.run(["/bin/sh", "-c", '"$@" >"$AZAHAR_STDOUT" 2>&1 </dev/null & echo $!', "sh", *args],
                       env=dict(os.environ, HOME=HOME, AZAHAR_STDOUT=stdout_path),
                       capture_output=True, text=True, check=True)
    return int(r.stdout)


def alive(pid):
    try:
        os.kill(pid, 0)
        return True
    except ProcessLookupError:
        return False


def main():
    p = argparse.ArgumentParser()
    p.add_argument("title")
    p.add_argument("--shots", required=True, help="comma-separated seconds after launch")
    p.add_argument("--movie")
    p.add_argument("--out", default=os.path.join(VC, "local", "playtest"))
    a = p.parse_args()

    ensure_config()
    sys.path.insert(0, os.path.join(AZAHAR_DIR, "scripting"))
    from AzaharRPC import AzaharRPC  # shipped with Azahar

    os.makedirs(a.out, exist_ok=True)
    args = [EXE, "-w"] + (["-p", os.path.abspath(a.movie)] if a.movie else []) + [os.path.abspath(a.title)]
    stdout_path = os.path.join(a.out, "azahar_stdout.txt")
    pid = launch(args, stdout_path)
    rpc, start = AzaharRPC(timeout=2), time.monotonic()
    try:
        for t in [float(x) for x in a.shots.split(",")]:
            time.sleep(max(0.0, start + t - time.monotonic()))
            if not alive(pid):
                print(f"{t:5.0f}s  Azahar exited early; see {stdout_path} and {LOG}")
                return 1
            path = os.path.join(a.out, f"shot_{int(t):03d}s.png")
            try:
                rpc.save_screenshot(path)
                print(f"{t:5.0f}s  {path}", flush=True)
            except Exception as e:
                print(f"{t:5.0f}s  screenshot failed ({type(e).__name__})", flush=True)
    finally:
        if alive(pid):
            os.kill(pid, signal.SIGKILL)  # Azahar ignores SIGTERM; there is no unsaved state worth keeping
        while alive(pid):
            time.sleep(0.1)

    shutil.copy(LOG, os.path.join(a.out, "azahar_log.txt"))
    movie_lines = [l for l in open(LOG, errors="replace") if "Movie" in l]
    for line in movie_lines:
        print("log:", line.split("] ", 1)[-1].rstrip())
    if any("Expected to read type" in l for l in movie_lines):
        print("WARNING: movie record layout does not match this title (inputs desynced)")
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
