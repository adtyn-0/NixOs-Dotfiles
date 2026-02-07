{ config, pkgs, ... }:

{
  # Enable niri
  programs.niri.enable = true;

  # Needed for portals, screenshots, file pickers, OBS, etc.
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Environment & tools commonly needed in a bare Wayland session
  environment.systemPackages = with pkgs; [
    niri
    waybar
    mako
    wl-clipboard
    grim
    slurp
    wofi
  ];

  ## Polkit + secrets (same as your Hyprland setup)
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.niri.enableGnomeKeyring = true;

  ## Make sure DBus exists for portals
  services.dbus.enable = true;
}
