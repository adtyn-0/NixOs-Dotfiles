{ config, pkgs, ... }:

{
  ## ---- Niri + Wayland ----
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  ## Waybar is started by niri (spawn-at-startup in KDL)
  programs.waybar.enable = true;

  ## Explicit session identity (niri does not set these itself)
  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_DESKTOP = "niri";
  };

  ## Portals (required for screenshots, OBS, file pickers, etc.)
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      gnome-keyring
    ];
    config.niri = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    };
  };

  ## Greeter: greetd + tuigreet
#  services.greetd = {
#   enable = true;
#   settings = {
#     default_session = {
#       command = ''
#         ${pkgs.tuigreet}/bin/tuigreet \
#           --time \
#           --cmd "${pkgs.dbus}/bin/dbus-run-session ${pkgs.niri}/bin/niri"
#       '';
#     };
#   };
# }; 

# For Now
  services.greetd.enable = false;


  ## Runtime tools expected in a niri session
  environment.systemPackages = with pkgs; [
    waybar
    mako
    wl-clipboard
    grim
    slurp
    wofi
    xwayland-satellite
    xdg-desktop-portal-wlr
  ];

  ## Polkit + secrets
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.niri.enableGnomeKeyring = true;

  ## DBus is mandatory for portals and waybar modules
  services.dbus.enable = true;
}
