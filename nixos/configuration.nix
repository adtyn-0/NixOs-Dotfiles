{ config, pkgs, ... }: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Custom modules
      ./modules/packages.nix
      # ./modules/hyprland.nix
      ./modules/kde.nix
      # ./modules/cosmic.nix

      # WireGuard
      #./modules/wiregaurd.nix
    ];

  # NixOs Configurations
  system.copySystemConfiguration = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.optimise.automatic = true;
  
  # CPU Frequency Auto Config (powerprofile)
  # services.auto-cpufreq.enable = true;
  
  boot.loader = {
  efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };
  grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    configurationLimit = 2;
    gfxmodeEfi = "1024x768x32";
    # fontSize = 32;
    gfxpayloadEfi = "keep";

    # Required for Windows dual-boot discovery
    useOSProber = true;
  };
};


  # Blacklisted in default
  # Camera and Nvidia Open-source
  boot.blacklistedKernelModules = [ "uvcvideo" "nouveau" ];
  

  # Graphics - Hybrid Setup (Intel + NVIDIA Offload)
  services.xserver.videoDrivers = [ "nvidia" "modesetting" ];
  
  hardware.graphics = {
  enable = true;
  enable32Bit = true;
};





  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      intelBusId = "PCI:0:2:0";    # Intel GPU bus ID (from `lspci`)
      nvidiaBusId = "PCI:1:0:0";   # NVIDIA GPU bus ID (from `lspci`)
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

  nixpkgs.config.cudaSupport = true;

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
    # jack.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  security.polkit.enable = true;


  programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; 
      dedicatedServer.openFirewall = true; 
  };

  networking.hostName = "nixos"; # Define your hostname.

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Bluetooth
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

  # Fonts
fonts.packages = with pkgs; [
  font-awesome
  udev-gothic-nf
  fira-code
  inter
  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-color-emoji
];


  # mozilla?
  programs.firefox.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adtyn = {
    isNormalUser = true;
    description = "Adityan Nampoothiry";
    extraGroups = [ "networkmanager" "wheel" "video" "adbusers" ];
    packages = with pkgs; [];
  };

  # Android
  programs.adb.enable = true;
  # services.udev.packages = [ pkgs.android-udev-rules ];

  # Neovim
  programs.neovim.enable = true;

  # File Manager
  # programs.thunar.enable = true;
  # programs.thunar.plugins = with pkgs.xfce; [
  #   thunar-archive-plugin
  #   thunar-volman
  # ];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images


environment.etc."xdg/mimeapps.list".text = ''
  [Default Applications]
  image/jpeg=org.gnome.Loupe.desktop
  image/png=org.gnome.Loupe.desktop
  image/webp=org.gnome.Loupe.desktop
  image/gif=org.gnome.Loupe.desktop
  image/svg+xml=org.gnome.Loupe.desktop
  image/tiff=org.gnome.Loupe.desktop
  image/bmp=org.gnome.Loupe.desktop
  image/x-ms-bmp=org.gnome.Loupe.desktop
  image/avif=org.gnome.Loupe.desktop
  image/heic=org.gnome.Loupe.desktop
  image/vnd.microsoft.icon=org.gnome.Loupe.desktop
  image/x-icon=org.gnome.Loupe.desktop
  image/x-exr=org.gnome.Loupe.desktop
  image/x-pnm=org.gnome.Loupe.desktop
  image/x-tga=org.gnome.Loupe.desktop
  image/psd=org.gnome.Loupe.desktop
  image/x-dds=org.gnome.Loupe.desktop
  image/x-qoi=org.gnome.Loupe.desktop
  image/x-farbfeld=org.gnome.Loupe.desktop
'';

  # Credential Manager
  # services.gnome.gnome-keyring.enable = true;

  # IPC
  services.dbus.enable = true;

  # Environment variables (NOT NEEDED)
  # environment.sessionVariables = {
  # XDG_SESSION_TYPE = "wayland";
  # XDG_CURRENT_DESKTOP = "Hyprland";
  # XDG_SESSION_DESKTOP = "Hyprland";
  # WLR_RENDERER = "vulkan";
  # WLR_NO_HARDWARE_CURSORS = "1";
  #
  # GTK_USE_PORTAL = "1";
  # NIXOS_XDG_OPEN_USE_PORTAL = "1";
  # SDL_VIDEODRIVER = "wayland";
  # _JAVA_AWT_WM_NONREPARENTING = "1";
  # CLUTTER_BACKEND = "wayland";
  #
  # NIXOS_OZONE_WL = "1";
  # MOZ_ENABLE_WAYLAND = "1";
  # ELECTRON_DISABLE_GPU = "true";
  # QT_QPA_PLATFORM = "wayland;xcb";
  #};

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  
  #CloudFlare settings
  services.cloudflare-warp.enable = true;

  # List services that you want to enable:
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8000 3000 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  system.stateVersion = "24.11"; # Did you read the comment?
}
