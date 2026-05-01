{
  config,
  lib,
  pkgs,
  lazyvim,
  ...
}:

let
  lazyvimModule = lazyvim.homeManagerModules.default;
in
{
  imports = [
    lazyvimModule
    # ./user/shells/sh.nix
    # ./user/terminals/kitty.nix
    # ./user/WM/hyprland.nix
    ./user/programs.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "terrya";
  home.homeDirectory = "/home/terrya";

  # Lazyvim flake
  programs.lazyvim = {
    installCoreDependencies = true;
    enable = true;
    extras = {
      lang.nix.enable = true;
      lang.docker.enable = true;
      editor.telescope.enable = true;
      editor.fzf.enable = true;
      ai.codeium.enable = true;
    };
    extraPackages = with pkgs; [
      # Nix ecosystem
      nixd # Nix language server
      alejandra # Nix formatter

      # Additional tools
      tree-sitter # CLI for grammar development
      fzf # Fuzzy finder
      gh # GitHub CLI

      # Custom language support
      postgresql # Database CLI tools
    ];
  };

  # Zsh
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "af-magic";
      plugins = [
        "aliases"
        "fzf"
        "git"
        "systemadmin"
        "systemd"
        "zoxide"
        "zsh-interactive-cd"
        "zsh-navigation-tools"
        "themes"
        "tmux"
        "direnv"
        "tailscale"
      ];
    };
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -l";
      la = "ls -la";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      cd = "z";
      ".." = "cd ..";
      nixrebuild = "sudo nixos-rebuild switch --flake .#nixos && sudo systemctl daemon-reload";
      neovim = "nix run ~/neovim-flake# ";
      vl = "NVIM_APPNAM=lazyvim nvim";
      homerun = "home-manager switch --flake .";
      dbeb = "distrobox enter ubuntu";
      sudovim = "sudo -E nvim ";
    };
  };

  # SSh

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    codeium
    alejandra
    vscode-with-extensions
    vscodium-fhs
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
    antigravity-fhs
    nixd
    nixdoc
    nil
    prettierd
    live-server
    vscode-extensions.brettm12345.nixfmt-vscode
    ghostty
    tmuxPlugins.tokyo-night-tmux
  ];

  # tailscale
  services.tailscale-systray.enable = true;

  # Sceensaver
  services.xscreensaver.enable = true;
  services.xscreensaver.settings = {
    lock = false;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  home.stateVersion = "26.05"; # Please read the comment before changing.
}
