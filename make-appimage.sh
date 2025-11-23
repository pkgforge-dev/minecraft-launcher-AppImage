#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q minecraft-launcher | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/symbolic/apps/minecraft-launcher.svg
export DESKTOP=/usr/share/applications/minecraft-launcher.desktop
export LOCALE_FIX=1

# Deploy dependencies
quick-sharun /usr/bin/minecraft-launcher*

# strace picks up the minecraft install in HOME lol
rm -rf ./AppDir/lib/github

# Turn AppDir into AppImage
quick-sharun --make-appimage
