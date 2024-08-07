{
  description = "A very basic flake";

  inputs = {
    stable.url = "nixpkgs/nixos-24.05";
    unstable.url = "nixpkgs/nixos-unstable";
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "unstable";
    };
  };
  outputs = { self, stable, unstable, nixos-cosmic }:
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
      };
    };
}
