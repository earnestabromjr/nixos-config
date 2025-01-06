{ config, pkgs, ... }:

{
  imports = [
    ./user/shells/sh.nix
    ./user/terminals/kitty.nix
    ./user/WM/hyprland.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "terrya";
  home.homeDirectory = "/home/terrya";


  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    aljandra
    vscode-with-extensions
    vscodium-fhs
    direnv
    ripgrep
    zoxide
    unzip
    fzf
    fastfetch
    brave
    librewolf
    bitwarden-desktop
    fh
    git
    gitkraken
    github-cli
    neovim
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
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  #Nixpkgs
  nixpkgs.config.allowUnfreePredicate = _: true;

    # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
