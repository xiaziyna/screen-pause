#!/usr/bin/env bash
set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v xfconf-query >/dev/null 2>&1; then
  echo "xfconf-query not found. This script is for XFCE."
  exit 1
fi

if [ ! -d "$ROOT/.venv" ]; then
  python3 -m venv "$ROOT/.venv"
  "$ROOT/.venv/bin/pip" install -r "$ROOT/requirements.txt"
fi

xfconf-query -c xfce4-keyboard-shortcuts \
  -p "/commands/custom/<Control><Alt>p" \
  -n -t string -s "${ROOT}/.venv/bin/python ${ROOT}/screen_select_basic.py"

echo "Hotkey installed: ctrl+alt+p"
