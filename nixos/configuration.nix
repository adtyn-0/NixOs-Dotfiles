#Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  system.copySystemConfiguration = true;
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 2;

  # Blacklisted in default
  # Camera and Nvidia Open-source
  boot.blacklistedKernelModules = [ "uvcvideo""nouveau" ];

  # Graphics - Hybrid Setup (Intel + NVIDIA Offload)
  services.xserver.videoDrivers = [ "intel" "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      intelBusId = "PCI:0:2:0";    # Replace with actual Intel GPU bus ID (from `lspci`)
      nvidiaBusId = "PCI:1:0:0";   # Replace with actual NVIDIA GPU bus ID (from `lspci`)
      offload.enable = true;
      offload.enableOffloadCmd = true;
    };

    modesetting.enable = true;
    powerManagement.enable = false;
    nvidiaSettings = true;
    open = false;
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="backlight", ACTION=="add", GROUP="video", MODE="0664"
  '';


  # Configure session to use offloading for X11 session
  # services.xserver.displayManager.sessionCommands = ''
  #   export __NV_PRIME_RENDER_OFFLOAD=1
  #   export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
  #   export __GLX_VENDOR_LIBRARY_NAME=nvidia
  #   export __VK_LAYER_NV_optimus=NVIDIA_only
  # '';
  
  # Audio 
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Greeter
  #services.greetd = {
  #	enable = true;
  #	settings = {
  #	 default_session = {
  #		command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
  #		user = "greeter";
  #		};
  #	 };	
  # };

  #Hyprland
  programs.hyprland = {
    enable = true;
  };
  programs.waybar.enable = true;
  # programs.nm-applet.enable = true;
  services.hypridle.enable = true;

  xdg.portal = {
    enable = true;
    config = {
      common.default = "*";
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  #Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };
  services.blueman.enable = true;


  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  #Fonts
  fonts.packages = with pkgs; [ font-awesome udev-gothic-nf fira-code ];


  #mozilla?
  programs.firefox.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adtyn = {
    isNormalUser = true;
    description = "Adityan Nampoothiry";
    extraGroups = [ "networkmanager" "wheel" "video" "adbusers" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    android-studio
    curl
    nix-search
    networkmanager
    networkmanagerapplet
    xfce.tumbler
    #gnome-keyring
    #libsecret
    dbus
    gsettings-desktop-schemas
    blueman
    fastfetch
    fff
    pandoc
    libreoffice-qt
    hunspell
    xz
    fzf
    ffmpeg
    mpv
    spotify
    kitty
    gitFull
    git-lfs
    brave
    vscodium-fhs
    obsidian
    brightnessctl
    alsa-utils
    grim
    wl-clipboard
    slurp
    #hypridle
    mako
    libnotify
    hyprpaper
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    mongodb-compass
    mongosh
  # Python
    python3
    python312Packages.virtualenv
    python312Packages.pip

  # C/C++ & Build Tools
    gcc
    gdb
    clang
    cmake
    ninja
    pkg-config

  # Java
    openjdk
  
  # Android
    flutter

  # Node.js
    nodejs

  # Rust
    rustc
    cargo

  # Go (optional)
    go
  ] ;

  # Android
    programs.adb.enable = true;
    services.udev.packages = [ pkgs.android-udev-rules ];


  programs.neovim.enable = true;

  # File Manager
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  
  # Credential Manager
  # services.gnome.gnome-keyring.enable = true;

  # IPC
  services.dbus.enable = true;

  # Environment variables
  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = "1";

    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";

    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_DISABLE_GPU = "true";
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8000 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
