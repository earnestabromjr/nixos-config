{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Eza
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
    colors = "auto";
    git = true;
  };

  programs.claude-code = {
    enable = true;
  };

  programs.opencode = {
    enable = true;
  };

  programs.television = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.tmux.plugins = with pkgs; [
  tmuxPlugins.tokyo-night-tmux
  ];
}
