{
  description = "A very basic flake";

  inputs = {
    stable.url = "nixpkgs/nixos-23.11";
    unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, stable, unstable }:
    {
      nixosConfigurations = {
        CirnOS = stable.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [ ./configuration.nix ];

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
