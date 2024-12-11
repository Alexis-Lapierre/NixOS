{ lib, config, ... }:
{
  options.AlexisLapierre.eurkey_down.enable = lib.mkEnableOption ''
    Create additional keyboard layout: EurKey Down.
    Eurokey layer 3 and 4 (accesible with AltGr) shifted down to layer 1 and 2.
  '';

  config = lib.mkIf config.AlexisLapierre.eurkey_down.enable {
    # services.xserver.xkb.extraLayouts.eurkey_down = {
    #   description = "Eurkey layout shifted down - layer 3 and 4 are moved down to layer 1 and 2.";
    #   languages = [ "eng" "fr" ];
    #   symbolsFile = ./layout/symbols/eurkey_down;
    # };
    services.xserver.xkb.extraLayouts.eurkey_edit = {
      description = "Eurkey Alexis";
      languages = [ "eng" "fr" ];
      symbolsFile = ./layout/symbols/eurkey_edit;
    };
  };
}
