# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  ns = pkgs.writeShellScriptBin "ns" (builtins.readFile ./nixpkgs.sh);
  mangoPkg = inputs.mangowc.packages.${pkgs.system}.mango;
  start-mango = pkgs.writeShellScriptBin "start-mango" ''
    LOG=/tmp/mango-start.log
    echo "===== Mango session start: $(date) =====" >> "$LOG"
    env >> "$LOG" 2>&1

    # Unset any existing Wayland environment from parent compositor
    unset WAYLAND_DISPLAY
    unset DISPLAY
    unset NIRI_SOCKET

    # Set Wayland environment for our session
    export XDG_SESSION_TYPE=wayland
    export XDG_CURRENT_DESKTOP=mangowm

    echo "Starting mango..." >> "$LOG"
    exec ${mangoPkg}/bin/mango -d >> "$LOG" 2>&1
  '';
  mango-session = pkgs.runCommandLocal "mango-session" { passthru.providedSessions = [ "mango" ]; } ''
        mkdir -p $out/share/wayland-sessions
        cat > $out/share/wayland-sessions/mango.desktop <<EOF
    [Desktop Entry]
    Encoding=UTF-8
    Name=Mango WM
    DesktopNames=mangowm;wlroots
    Comment=Mango Wayland compositor
    Exec=${start-mango}/bin/start-mango
    Icon=mango
    Type=Application
    EOF
  '';
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./system/services.nix
    ./system/virt.nix
    ./system/containers/pegaprox.nix
    ./system/containers/my-dev.nix
    ./system/WM/qtile.nix
    ./system/WM/hyprland.nix
    ./system/WM/dms.nix
  ];

  # Bootloader.
  boot = {
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
    loader.efi.canTouchEfiVariables = true;
    # Enable Containers
    enableContainers = true;
  };

  # Decrypt and mount luks btrfs drive
  environment.etc."crypttab" = {
    text = "arch UUID=ab39df73-f1d1-4bcc-9699-ad55088daa18 /etc/secrets/riot.key luks,nofail";
    mode = "0644";
  };
  fileSystems."/mnt/riot" = {
    device = "/dev/mapper/arch";
    fsType = "btrfs";
    options = [
      "defaults"
      "nofail"
    ];
  };

  # Enable networking
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = false;
    nat = {
      enable = true;
      internalInterfaces = [ "ve-+*" ];
      externalInterface = "wlp0s20f3";
    };
  };
  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
  # services.displayManager.gdm.enable = true;
  # services.displayManager.defaultSession = "niri";
  services.desktopManager.gnome.enable = true;
  services.displayManager.sessionPackages = [ mango-session ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:swapescape";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.terrya = {
    isNormalUser = true;
    description = "Terry Abrom";
    extraGroups = [
      "networkmanager"
      "wheel"
      "disk"
      "flatpak"
      "qemu"
      "kvm"
      "libvirtd"
      "docker"
      "sshd"
      "audio"
      "video"
    ];
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "codeium"
    ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    inputs.home-manager.packages.${pkgs.system}.home-manager
    vim
    wget
    hwinfo
    htop
    btop
    cryptsetup
    stow
    git
    luajitPackages.tree-sitter-cli
    tree-sitter
    code-cursor-fhs
    niri
    dms-shell
    fuzzel
    alacritty
    quickshell
    matugen
    dgop
    cava
    tmux
    rustup
    beam28Packages.elixir_1_20
    beam28Packages.erlang
    typescript
    go
    lazygit
    antigravity-fhs
    devbox
    valent
    (python313Packages.qtile-extras.overridePythonAttrs (old: {
      doCheck = false;
    }))
    rofi
    waybar
    dunst
    pcmanfm
    libnotify
    awww
    rsync
    fd
    glances
    ansible
    ansible-lint
    sshpass
    terraform
    luajitPackages.lua-lsp
    kdePackages.qt6ct
    nixfmt
    qdirstat
    virt-manager
    qemu-utils
    nix-search-tv
    wayvnc
    realvnc-vnc-viewer
    ns
    inputs.nix-software-center.packages.${system}.nix-software-center
    turbovnc
    remmina
    inputs.nixvim.packages.x86_64-linux.default
    foot
    wl-clipboard
    grim
    wmenu
    slurp
    swaybg
    start-mango
    mango-session
    gemini-cli
  ];

  programs = {
    nh = {
      enable = true;
      flake = "/home/terrya/nixos-config";
    };
    mango.enable = true;
    firefox.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  # XDG
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services = {
    openssh.enable = true;
    flatpak.enable = true;

  };

  # Nix features
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      # substituters = [ "https://hyprland.cachix.org" ];
      # trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };

  # Fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      font-awesome
      source-han-sans
      nerd-fonts.jetbrains-mono
      nerd-fonts._3270
      nerd-fonts.caskaydia-cove
    ];
    fontconfig.enable = true;
  };
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") {
      inherit pkgs;
    };
  };

  system.stateVersion = "26.05";

}
