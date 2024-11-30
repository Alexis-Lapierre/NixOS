{ config, lib, unstable, ... }:
{
  options.AlexisLapierre.programming = {
    cpp.enable = lib.mkEnableOption "Add C++ compiler and clangd lsp";
    exercism.enable = lib.mkEnableOption ''
      Add Exercism binary to the build.
    '';
    gleam.enable = lib.mkEnableOption "Add Gleam";
    rust.enable = lib.mkEnableOption "Add Rust compiler";
  };

  config = lib.mkMerge [
    (lib.mkIf config.AlexisLapierre.programming.cpp.enable {
      environment.systemPackages = with unstable; [ clang cmake ninja ];
    })
    (lib.mkIf config.AlexisLapierre.programming.exercism.enable {
      environment.systemPackages = with unstable; [ exercism ];
    })
    (lib.mkIf config.AlexisLapierre.programming.gleam.enable {
      environment.systemPackages = with unstable; [ erlang_27 gleam ];
    })
    (lib.mkIf config.AlexisLapierre.programming.rust.enable {
      environment.systemPackages = with unstable; [ 
        cargo clippy rust-analyzer rustc rustfmt
      ];
    })
  ];
}
