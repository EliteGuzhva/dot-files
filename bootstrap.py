#!/usr/bin/python3

import os
import shutil
import platform
from typing import Tuple

OS_DIR_MAP = {
    "Darwin": "mac",
    "Linux": "linux",
}

COMMON_DIR = "common"


def get_user_root(root: str) -> str:
    user_home = os.path.expanduser("~")
    root_parts = root.split("/")
    root_parts[0] = user_home
    user_root = os.path.join(*root_parts)

    return user_root


def get_src_dst(root: str, user_root: str, name: str) -> Tuple[str, str]:
    src = os.path.join(os.path.abspath(root), name)
    dst = os.path.join(os.path.abspath(user_root), name)

    return src, dst


def remove(f: str):
    if os.path.islink(f):
        os.unlink(f)
    elif os.path.isfile(f):
        os.remove(f)
    elif os.path.isdir(f):
        shutil.rmtree(f)


def symlink(src: str, dst: str, dry_run: bool = False):
    print(f"Symlinking '{src}' -> '{dst}'")

    if dry_run:
        return

    try:
        os.symlink(src, dst)
    except FileExistsError:
        try:
            remove(dst)
            os.symlink(src, dst)
        except PermissionError as e:
            print(f"Symlink failed with message: {e}")


def install_folder(folder: str, dry_run: bool = False):
    for root, dirs, files in os.walk(folder):
        user_root = get_user_root(root)

        if root == folder or root.endswith(".config"):
            for dir in dirs:
                if dir == ".config":
                    continue

                src, dst = get_src_dst(root, user_root, dir)
                symlink(src, dst, dry_run)

        if root == folder:
            for file in files:
                src, dst = get_src_dst(root, user_root, file)
                symlink(src, dst, dry_run)


if __name__ == "__main__":
    print("Bootstrapping dot files...")

    # Detect OS
    OS = platform.system()
    print(f"Running on {OS}")

    # Choose OS-specific folder
    os_dir = OS_DIR_MAP.get(OS)
    if os_dir is None:
        raise OSError("Not supported OS")

    # Install common settings
    print("\nInstalling common configs:")
    install_folder(COMMON_DIR)

    # Install OS-specific settings
    print("\nInstalling OS-specific configs:")
    install_folder(os_dir)
