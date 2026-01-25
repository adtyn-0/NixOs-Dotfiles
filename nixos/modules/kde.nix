{ config, pkgs, ... }:

{
  # KDE Settings

  services = {
    # Enable KDE Plasma 6 desktop
    desktopManager.plasma6.enable = true;

    # Display manager (pick ONE — LY or SDDM)
    # displayManager.sddm.enable = true;

    # Enable Wayland support in SDDM (if using SDDM)
    # displayManager.sddm.wayland.enable = true;

    # TUI display manager
    displayManager.ly.enable = true;

    # XRDP (X11 only)
    xrdp = {
      defaultWindowManager = "startplasma-x11";
      enable = true;
      openFirewall = true;
    };

    # X11 is REQUIRED for KDE X11 sessions and XRDP
    xserver = {
      enable = true;

      # X11 keyboard layout
      xkb = {
        layout = "us";
        variant = "";
      };

      # # X11 video drivers (moved here from configuration.nix)
      # videoDrivers = [ "nvidia" "modesetting" ];
    };
  };

  environment.systemPackages = with pkgs; [
    # KDE
    kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
    kdePackages.kcalc # Calculator
    kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
    kdePackages.kcolorchooser # A small utility to select a color
    # kdePackages.kolourpaint # Easy-to-use paint program
    kdePackages.ksystemlog # KDE SystemLog Application
    kdePackages.sddm-kcm # Configuration module for SDDM
    kdiff3 # Compares and merges 2 or 3 files or directories
    hardinfo2 # System information and benchmarks for Linux systems
    # haruna # Open source video player built with Qt/QML and libmpv
    xclip # Tool to access the X clipboard from a console application
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration # Comment out this line if you use KDE Connect
    # kdepim-runtime # Unneeded if you use Thunderbird, etc.
    konsole # Comment out this line if you use KDE's default terminal app
    breeze
    breeze-icons
    breeze-gtk
    oxygen
  ];
}
