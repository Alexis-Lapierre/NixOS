{
  description = "A very basic flake";

  inputs = {
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "stable";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "stable";
    };

    stable.url = "nixpkgs/nixos-24.11";
    unstable.url = "nixpkgs/nixos-unstable";
  };
  outputs = { self, stable, unstable, nixos-cosmic, nixos-hardware, home-manager }:
    {
      nixosConfigurations = let 
        makeModule = baseModule : [
          {
            nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
          nixos-cosmic.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
          baseModule
        ];
        makeSpecialArgs = system : {
          unstable = import unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };
       in  {
        CirnOS = stable.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = makeModule ./devices/CirnOS/configuration.nix;

          specialArgs = makeSpecialArgs system;
        };

        MomBasement = stable.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = makeModule ./devices/MomBasement/configuration.nix;

          specialArgs = makeSpecialArgs system;
        };

        PocketWizard = stable.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = makeModule ./devices/PocketWizard/configuration.nix ++ [ nixos-hardware.nixosModules.gpd-pocket-3 ];
          specialArgs = makeSpecialArgs system;
        };
      };
    };
}
