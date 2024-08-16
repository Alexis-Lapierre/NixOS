{
  description = "Rise up, ziggers";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system: 
    let pkgs = import nixpkgs { inherit system; }; in
    {
      devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        clang
        cmake
        ninja
      ];
      shellHook = ''
        clang --version
        clangd --version
        cmake --version
        ninja --version
        fish
      '';
      };
    }
  );
}
