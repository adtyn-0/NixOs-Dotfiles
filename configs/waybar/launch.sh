#!/usr/bin/env bash
set -euo pipefail

config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/waybar"
style="$config_dir/style.css"

desktop="${XDG_CURRENT_DESKTOP:-}"
desktop_lc="$(printf '%s' "$desktop" | tr '[:upper:]' '[:lower:]')"

use_hyprland_config=false

if [[ "$desktop_lc" == *"hyprland"* ]] || [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
  use_hyprland_config=true
elif [[ "$desktop_lc" != *"niri"* ]] && [[ -z "${NIRI_SOCKET:-}" ]] && pgrep -x Hyprland >/dev/null 2>&1; then
  # Fallback when session vars are missing during manual startup.
  use_hyprland_config=true
fi

config="$config_dir/config.jsonc"
if $use_hyprland_config; then
  config="$config_dir/config.hyprland.jsonc"
fi

exec waybar -c "$config" -s "$style"
