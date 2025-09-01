{
  description = "A simple example of a test suite";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    # hyprland-xdph-git.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    # hyprland-protocols-git.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    # # This overrides each input for `hyprland-nix` to use the ones
    # # specified above, which are locked by you.
    # hyprland-nix.url = "github:spikespaz/hyprland-nix";
    # hyprland-nix.inputs = {
    #     hyprland.follows = "hyprland";
    #     hyprland-xdph.follows = "hyprland-xdph-git";
    #     hyprland-protocols.follows = "hyprland-protocols-git";
    # };
  };

  outputs = { nixpkgs, home-manager, hyprland, ... } @ inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = { inherit inputs; };
        inherit system;
        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nixuser = import ./home.nix;
          }
        ];
      };
    };
    
  };
}
