{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }: 
    utils.lib.eachDefaultSystem (system: 
        let pkgs = import nixpkgs { inherit system; }; in  
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            cargo
            clippy
            rust-analyzer
            rustc
            rustfmt
          ];
          shellHook = ''
            cargo --version
            cargo clippy --version
            rust-analyzer --version
            rustc --version
            rustfmt --version
            fish
          '';
          };
      }
    );
}

