{
  description = "A very basic flake";

  inputs = {
    stable.url = "nixpkgs/nixos-23.11";
    unstable.url = "nixpkgs/nixos-unstable";
    unstable-small.url = "nixpkgs/nixos-unstable-small";
  };

  outputs = { self, stable, unstable, unstable-small }:
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
            unstable-small = import unstable-small {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
      };
    };
}
