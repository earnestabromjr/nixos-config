{ pkgs, ... }:

{
  # Fish
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -l";
      la = "ls -la";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      cd = "z";
      ".." = "cd ..";
      neovim = "nix run ~/neovim-flake# ";
      homerun = "home-manager switch --flake .";
      f = "fastfetch";
    };
    shellInit = ''
      set -x EDITOR nvim
    '';
    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
    ];
    interactiveShellInit = ''
      zoxide init fish | source
    '';
  };
}
