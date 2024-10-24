{ lib, config, pkgs, ... }:
{
  options.AlexisLapierre.cosmicEpoch = {
    enable = lib.mkEnableOption "use Cosmic Epoch";
  };

  config = lib.mkIf config.AlexisLapierre.cosmicEpoch.enable {
    services = {
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
    environment = { systemPackages = with pkgs; [
        wofi # Used in a shortcut
    ];};
  };
}
