{ config, pkgs, ... }:

{
  # Sway enable
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Packages extra
  environment.systemPackages = with pkgs; [
    wl-clipboard
    mako
    foot
    fuzzel
    waybar
    swaybg
    #swaylock
    #swayidle
    grim
    slurp
  ];

  # Secret Keeper
  services.gnome.gnome-keyring.enable = true;
}
