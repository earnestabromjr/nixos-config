# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./system/services.nix
    ./system/virt.nix
    ./system/WM/qtile.nix
    ./system/WM/dms.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Containers
  boot.enableContainers = true;

  # Decrypt and mount luks btrfs drive
  systemd.services."systemd-cryptsetup@arch" = {
    enable = true;
  };
  environment.etc."crypttab" = {
    text = "arch UUID=85ce3c95-b34b-4015-8d0a-4b1ee1764908 none luks";
    mode = "0644";
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
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
      "sshd"
      "audio"
      "video"
    ];
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;

  # Programs
  programs = {
    firefox.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    hwinfo
    htop
    btop
    neovim
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
    python313Packages.qtile-extras
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
    packer
    luajitPackages.lua-lsp
  ];

  virtualisation.libvirtd.enable = true;

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

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services = {
    openssh.enable = true;
    flatpak.enable = true;

  };

  networking.firewall.enable = false;

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
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
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

  system.stateVersion = "26.05";

}
