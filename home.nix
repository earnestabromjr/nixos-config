{ config, pkgs, ... }:

{
  imports = [
    ./user/shells/sh.nix
    ./user/terminals/kitty.nix
    # ./user/WM/hyprland.nix
    ./user/programs.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "nixuser";
  home.homeDirectory = "/home/nixuser";



  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    alejandra
    vscode-with-extensions
    vscodium-fhs
    code-cursor-fhs
    ripgrep
    zoxide
    unzip
    fzf
    eza
    yq-go
    xz
    p7zip
    zip
    fastfetch
    brave
    librewolf
    bitwarden-desktop
    fh
    git
    gitkraken
    github-cli
    neovim
    lazygit
    gnupg
    python3
    bat
    gcc
    rustup
    nodejs
    curl
    lua
    stow
    zed-editor
    nixd
    nixdoc
    nil
    prettierd
    live-server
    vscode-extensions.brettm12345.nixfmt-vscode

    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    nix-output-monitor
    hugo
    glow
    btop
    iotop
    iftop
    strace
    ltrace
    lsof
    sysstat
    ethtool
    pciutils
    usbutils

  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  #Nixpkgs
  nixpkgs.config.allowUnfreePredicate = _: true;

    # Let Home Manager install and manage itself.
  #  programs.home-manager.enable = true;

   programs.git = {
    enable = true;
    userName = "earnestabromjr";
    userEmail = "abromearnest@gmail.com";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}
