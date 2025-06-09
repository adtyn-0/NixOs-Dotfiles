{ config, pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    android-studio
    qbittorrent-enhanced
    curl
    nix-search
    networkmanager
    networkmanagerapplet
    xfce.tumbler
    # gnome-keyring
    # libsecret
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
    # hypridle
    mako
    libnotify
    hyprpaper
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    mongodb-compass
    mongosh
    bruno
    bruno-cli

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

    # Go
    go
  ];
}
