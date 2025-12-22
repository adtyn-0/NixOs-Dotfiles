{ config, pkgs, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [


    # Development Tools & Languages
    #Lua stuff
    lua5_4_compat
    luarocks
    lua-language-server

    # Python stuff
    python3
    python312Packages.virtualenv
    python312Packages.pip

    # C/C++ & Build Tools
    gcc
    gdb
    libclang
    cmake
    ninja
    # pkg-config

    # Java stuff
    openjdk

    # Android stuff
    android-studio
    #flutter

    # Node.js
    nodejs

    # Rust
    rustc
    cargo

    # Go
    go

    # Assembly
    nasm
    asm-lsp

    # Utilities
    curl
    nix-search
    fzf
    ripgrep
    fd
    fastfetch
    fff
    xz
    p7zip
    brightnessctl
    alsa-utils
    pavucontrol
    util-linux
    wireguard-tools
    
    # Mini Project
     gnumake42
    # busybox
     cpio
     bc
    # ncurses
    
    # System & Network
    networkmanager
    networkmanagerapplet
    dbus
    gsettings-desktop-schemas
    blueman

    # Desktop Integration
    xfce.tumbler
    xdg-desktop-portal
    # xfce.thunar
    nautilus
    papirus-icon-theme
    loupe
    imv
    
    # Apps
    qbittorrent-enhanced
    pandoc
    libreoffice-qt
    hunspell
    ffmpeg
    mpv
    spotify
    kitty
    brave
    vscodium-fhs
    obsidian
    qemu_full

    # Git & Related
    gitFull
    git-lfs

    # API & Database Tools
    mongodb-compass
    mongosh
    bruno
    bruno-cli

    # GTK Support
    gtk3
    mesa-demos

    # Gaming
    lutris
    # mgba

    # Optional (commented out)
    # gnome-keyring
    # libsecret
    # hypridle
  ];
}
