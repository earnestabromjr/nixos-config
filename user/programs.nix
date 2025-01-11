{pkgs, ...}:

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
    icons = true;
    colors = true;
    git = true;
  };
}
