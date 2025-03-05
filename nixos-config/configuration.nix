
{ config, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader Configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.grub.configurationLimit = 3;

  # File Systems
  fileSystems."/mnt/Work" = {
    device = "/dev/nvme0n1p5";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1000" "gid=100" ];
  };
  fileSystems."/mnt/Sahil" = {
    device = "/dev/nvme0n1p6";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=1001" "gid=101" ];
  };

  # Networking and Wireless
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    wireless.enable = false;
    networkmanager.wifi.backend = "wpa_supplicant";
    firewall.allowedTCPPorts = [ 5900 ];
  };
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["sahil"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # Timezone and Locale
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";

  # X11 & Wayland Setup
  services.xserver.enable = true;
  services= {
    displayManager = {
      sddm.enable = true;
      defaultSession = "hyprland";
    };
    desktopManager.plasma6.enable = true;
  };

  services.ollama = {
    enable = true;
    openFirewall = true;
    loadModels = [ "llama3.1:8b" ];
    host = "0.0.0.0";
    port = 11434;
  };

  xdg.mime.enable = true;
  xdg.mime.defaultApplications = {
    "application/pdf" = ["okular.desktop"];

    "image/jpeg" = ["org.kde.gwenview.desktop"];
    "image/png" = ["org.kde.gwenview.desktop"];
    "image/gif" = ["org.kde.gwenview.desktop"];
    "image/svg+xml" = ["org.kde.gwenview.desktop"];

    "text/plain" = ["org.kde.kate.desktop"];
    "video/mp4" = ["vlc.desktop"];
    "video/x-matroska" = ["vlc.desktop"];

    "x-scheme-handler-terminal" = [ "ghostty.desktop" ];
    "application/terminal" = [ "ghostty.desktop" ];
  };

  # Sound, Bluetooth & Pipewire
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  services.longview.mysqlPasswordFile = "/run/keys/mysql.password";
  services.logind.extraConfig = ''
    IdleAction=hybrid-sleep
    IdleActionSec=1min
  '';

  # User Setup
  users.users.sahil = {
    isNormalUser = true;
    description = "Sahil Bansal";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
  users.mysql.passwordFile = "/run/keys/mysql.password";

  # Allow Unfree Packages
  nixpkgs.config.allowUnfree = true;

  # Environment Variables
  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    NIXOS_OZONE_WL = "1";  # For Wayland support
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    TERMINAL = "ghostty";
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    # Basic utilities
    vim
    wget
    curl
    git
    kitty
    zsh
    feh
    imv
    zathura
    desktop-file-utils
    gwenview
    vlc
    kate
    zoxide
    bat
    unzip
    starship
    neofetch
    firefox

    # Development tools
    neovim
    vscode
    code-cursor
    jetbrains.goland
    gcc
    gnumake
    docker-compose
    mysql-workbench
    ghostty
    hugo
    qemu_full
    virt-manager
    virt-viewer

    # Languages and Language Servers
    python3
    go
    gopls
    cargo
    zig
    nodejs_20
    nodePackages.npm
    nodePackages.typescript
    nodePackages.typescript-language-server
    lua-language-server
    virtualenv
    python311Packages.pytest
    python311Packages.pip
    python311Packages.flask

    # Formatters and Linters
    nodePackages.prettier
    gofumpt
    stylua
    shellcheck
    shfmt

    # Neovim dependencies
    ripgrep
    fd
    fzf
    tree-sitter
    lazygit
    xclip

    # Wayland utilities
    wl-clipboard
    xdg-utils
    gtk3
    wayvnc
    swaybg
    swayidle
    swaylock
    waybar
    hyprpicker
    hyprshot
    hyprlock
    pywal
    blueman
    bluez
    rofi
    networkmanager
    wlogout
    brightnessctl
    playerctl


    # Applications
    discord
    obs-studio
    brave
    dunst
    spotify
    postman
    btop
    htop
    pavucontrol
    obsidian
    libreoffice
    staruml
    zed-editor
    syncthing
  ];

  # Shell Configuration
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # Hyprland and XDG Portal
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg = {
  portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      ];
    };
  };

  # System State Version
  system.stateVersion = "24.11";

  # Nix Settings
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
