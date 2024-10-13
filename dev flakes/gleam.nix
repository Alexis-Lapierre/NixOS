{
  description = "Rise up, Gleam programmers";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs ,... }: let
    system = "x86_64-linux";
  in {
    devShells."x86_64-linux".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in pkgs.mkShell {
      # create an environment with nodejs_18, pnpm, and yarn
      packages = with pkgs; [
        erlang
        gleam
        rebar3
      ];

      shellHook = ''
        gleam --version
        rebar3 --version

        fish
      '';
    };
  };
}
