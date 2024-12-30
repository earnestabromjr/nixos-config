{
  description = "A simple example of a test suite";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
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

  outputs = { nixpkgs, home-manager, ...} @ inputs:
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
        ];
      };
    };
    homeConfigurations = {
      terrya = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix];
      };
    };
  };
}
