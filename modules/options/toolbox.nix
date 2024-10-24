{ lib, config, pkgs, ... }:
{
  options.AlexisLapierre.toolbox.enable = lib.mkEnableOption ''
    Enable toolbox tool
  '';

  config = lib.mkIf config.AlexisLapierre.toolbox.enable {
    virtualisation.podman.enable = true;
    environment = { systemPackages = [ pkgs.toolbox ];};
  };
}
