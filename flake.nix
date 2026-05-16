{
  description = "Anakins flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lazyvim.url = "github:pfassina/lazyvim-nix/v15.13.0";
    mangowc = {
      url = "github:DreamMaoMao/mangowc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    nixvim.url = "github:earnestabromjr/nixvim";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      lazyvim,
      mangowc,
      nur,
      nix-software-center,
      nixvim,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lazyvimModule = lazyvim.homeManagerModules.default;
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          mangowc.nixosModules.mango
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm-backup";
              extraSpecialArgs = { inherit lazyvimModule; };
              users.terrya = { ... }: {
                imports = [
                  mangowc.hmModules.mango
                  (import ./home.nix)
                ];
              };
            };
          }
          nur.modules.nixos.default
        ];
      };

      # Supports: home-manager switch --flake .#terrya
      homeConfigurations.terrya = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit lazyvimModule; };
        modules = [
          mangowc.hmModules.mango
          ./home.nix
        ];
      };
    };
}
