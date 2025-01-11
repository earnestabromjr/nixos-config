{pkgs, ...}:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Exa
  programs.eza = {
    enable = true;
    enableAliases = true;
  };
}
