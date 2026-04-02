#!/usr/bin/env bash
set -euo pipefail

config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/waybar"
style="$config_dir/style.css"

desktop="${XDG_CURRENT_DESKTOP:-}"
desktop_lc="$(printf '%s' "$desktop" | tr '[:upper:]' '[:lower:]')"

if [[ "$desktop_lc" == *"hyprland"* ]] || [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
  config="$config_dir/config.hyprland.jsonc"
elif [[ "$desktop_lc" == *"niri"* ]] || [[ -n "${NIRI_SOCKET:-}" ]]; then
  config="$config_dir/config.jsonc"
else
  # Fallback when session vars are missing during manual startup.
  if pgrep -x Hyprland >/dev/null 2>&1; then
    config="$config_dir/config.hyprland.jsonc"
  else
    config="$config_dir/config.jsonc"
  fi
fi

exec waybar -c "$config" -s "$style"
