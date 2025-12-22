{ config, pkgs, ... }:

{
  # Hyprland and related tools
  programs.hyprland.enable = true;

  # Required when launching Hyprland manually from TTY
  # (polkit, portals, authentication)
  security.pam.services.hyprland = {};

  # Waybar (status bar for Hyprland)
  programs.waybar.enable = true;

  # Enable XWayland for X11 applications
  programs.xwayland.enable = true;

  # Hyprland-specific environment and utilities
  environment.systemPackages = with pkgs; [
    # Core Hyprland components
    hyprpaper

    # Wayland utilities and tools
    grim
    slurp
    wl-clipboard
    mako
  ];

  # Optional: if you ever enable this later
  # services.hypridle.enable = true;

  # XDG portal integration (REQUIRED for screenshots, OBS, file pickers, Steam)
  xdg.portal = {
    enable = true;

    # Required for Wayland compositors
    xdgOpenUsePortal = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
