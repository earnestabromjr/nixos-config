{
  description = "A simple example of a test suite";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
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
