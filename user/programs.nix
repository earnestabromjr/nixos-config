{pkgs, ...}:

{
  programs.direnv = {
    enable = true;
    enableZshIntergration = true;
    nix-direnv.enable = true;
  };

  # Exa
  programs.exa = {
    enable = true;
    enableAliases = true;
  };
}
