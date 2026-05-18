{
  config,
  pkgs,
  inputs,
  ...
}:

{
  containers.my-dev = {
    autoStart = true;

    # Enable private networking so it has its own isolated IP address
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";

    # If you want it to access the internet, you can bind it to your host's network interface
    # (Requires nat to be enabled on your host, or just set privateNetwork = false to share the host's network)

    # This 'config' block defines the NixOS configuration INSIDE the container
    config =
      { config, pkgs, ... }:
      {
        system.stateVersion = "26.05"; # Make sure this matches your host's stateVersion

        # Install your development tools here
        environment.systemPackages = with pkgs; [
          git
          neovim
          python3
          nodejs
          gcc
          zoxide
          fzf
          tmux
          direnv
          ghostty
        ];
        imports = [
          inputs.home-manager.nixosModules.home-manager
        ];
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.devuser = {
            imports = [
              ../../user/shells/sh.nix
            ];
            home.stateVersion = "26.05";
          };
        };

        # Create a user to work as
        users.users.devuser = {
          isNormalUser = true;
          extraGroups = [ "wheel" ];
          password = "dev"; # For local testing; recommend using authorizedKeys in production
        };
        programs = {
          zsh = {
            enable = true;
          };
        };

        users.defaultUserShell = pkgs.zsh;
        # Enable SSH so you can easily shell into it from your host terminal
        services.openssh = {
          enable = true;
          settings.PermitRootLogin = "yes";
        };

        # You can even run services isolated in this container!
        # services.postgresql.enable = true;
        # services.redis.enable = true;
      };
  };
}
