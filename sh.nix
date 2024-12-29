{ config, pkgs, ...}:

{
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
    };
  };
}
