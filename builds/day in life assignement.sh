#!/bin/sh
printf '\033c\033]0;%s\a' day in life assignement
base_path="$(dirname "$(realpath "$0")")"
"$base_path/day in life assignement.x86_64" "$@"
