{ pkgs, ... }:

{
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # Eza
    eza = {
      enable = true;
      enableZshIntegration = true;
      icons = "auto";
      colors = "auto";
      git = true;
    };

    claude-code = {
      enable = true;
    };

    opencode = {
      enable = true;
    };

    television = {
      enable = true;
      enableZshIntegration = true;
    };

    tmux.plugins = with pkgs; [
      tmuxPlugins.tokyo-night-tmux
    ];
  };
}
