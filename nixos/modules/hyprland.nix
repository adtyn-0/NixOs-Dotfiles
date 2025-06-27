{ config, pkgs, ... }: {
  # Hyprland
  programs.hyprland.enable = true;

  programs.waybar.enable = true;

  # programs.nm-applet.enable = true;

 #  services.hypridle.enable = true;

  xdg.portal = {
    enable = true;
    config = {
      common.default = "*";
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
