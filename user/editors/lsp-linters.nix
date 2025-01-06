{ config, pkgs, ...}:

{
  # Linting and formatting pkgs
  home.packages = with pkgs; [
    # Language servers
        nodePackages.typescript-language-server # JavaScript/TypeScript LSP
        nodePackages.vscode-langservers-extracted # HTML/CSS LSP

        # Formatters
        nodePackages.prettier # For JavaScript, HTML, CSS

        # Linters
        nodePackages.eslint # JavaScript linter
        nodePackages.stylelint # CSS linter
  ];
}
