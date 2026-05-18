{ pkgs, ... }:

{
  # Nushell
  programs.nushell = {
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
    extraEnv = ''
      $env.EDITOR = "nvim"
    '';
    # Nushell plugins are added as a list of packages
    plugins = with pkgs.nushellPlugins; [
      # query
      # formats
      # gstat
    ];
    extraConfig = ''
      # To initialize zoxide in Nushell (if not using programs.zoxide.enableNushellIntegration):
      # zoxide init nushell | save -f ~/.zoxide.nu
      # source ~/.zoxide.nu
    '';
  };
}
