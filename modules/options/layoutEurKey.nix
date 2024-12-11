{ lib, config, ... }:
{
  options.AlexisLapierre.eurkey_down.enable = lib.mkEnableOption ''
    Create additional keyboard layout: EurKey Alexis.
    Escape become layer 3.
    Caps locks become Escape.
    Everything else is default EurKey.
    This is done for Pocketwizard keyboard, lacking a proper Alt-Gr button
  '';

  config = lib.mkIf config.AlexisLapierre.eurkey_down.enable {
    services.xserver.xkb.extraLayouts.eurkey_alexis = {
      description = "Eurkey (Alexis Lapierre)";
      languages = [ "eng" ];
      symbolsFile = ./layout/symbols/eurkey_alexis;
    };
  };
}
