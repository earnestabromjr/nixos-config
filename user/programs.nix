{pkgs, ...}:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Exa
  programs.exa = {
    enable = true;
    enableAliases = true;
  };
}
