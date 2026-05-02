{
  config,
  lib,
  pkgs,
  lazyvimModule ? null,
  ...
}:

{
  imports = (if lazyvimModule != null then [ lazyvimModule ] else [ ]) ++ [
    # ./user/shells/sh.nix
    # ./user/terminals/kitty.nix
    # ./user/WM/hyprland.nix
    ./user/programs.nix
  ];

  home = {
    username = "terrya";
    homeDirectory = "/home/terrya";
  };

  home.activation.postActivation = ''
    mkdir -p "$HOME/.local/state/nvim/undo"
    mkdir -p "$HOME/.local/share/nvim/swap"
    mkdir -p "$HOME/.local/share/nvim/sessions"
    mkdir -p "$HOME/.local/share/nvim/shada"
    mkdir -p "$HOME/.cache/nvim/catppuccin"
  '';

  programs.lazyvim = {
    enable = true;
    installCoreDependencies = true;
    config.options = ''
      vim.opt.directory = vim.fn.expand("~/.local/share/nvim/swap//")
    '';
    extras = {
      lang.nix.enable = true;
      lang.docker.enable = true;
      editor = {
        telescope.enable = true;
        fzf.enable = true;
        leap.enable = true;
        snacks_picker.enable = true;
      };
      ai.codeium.enable = true;
    };
    extraPackages = with pkgs; [
      nixd
      alejandra
      tree-sitter
      fzf
      gh
      postgresql
    ];
    plugins.ssh = ''
      return {
        "nosduco/remote-sshfs.nvim",
        dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
        opts = { ui = { picker = "fzf-lua" } },
      }
    '';
  };

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
      nixrebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#nixos && sudo systemctl daemon-reload";
      neovim = "nix run ~/neovim-flake# ";
      vl = "NVIM_APPNAME=lazyvim nvim";
      homerun = "home-manager switch --flake .#terrya";
      dbeb = "distrobox enter ubuntu";
      sudoedit = "sudo -E nvim ";
    };
  };

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
    statix
    lazydocker
  ];

  services = {
    tailscale-systray.enable = true;
  };
  qt = {
    kvantum.enable = true;
  };
  programs.home-manager.enable = true;

  home.file = { };
  home.sessionVariables = { };

  home.stateVersion = "26.05";
}
