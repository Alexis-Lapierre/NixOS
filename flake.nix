{
  description = "A very basic flake";

  inputs = {
    stable.url = "nixpkgs/nixos-24.05";
    unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, stable, unstable }:
    {
      nixosConfigurations = {
        CirnOS = stable.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [ ./devices/CirnOS/configuration.nix ];

          specialArgs = {
            unstable = import unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };

        MomBasement = stable.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [ ./devices/MomBasement/configuration.nix ];

          specialArgs = {
            unstable = import unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
      };
    };
}
