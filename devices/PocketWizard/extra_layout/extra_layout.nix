{ ... }:
{
  services.xserver.xkb.extraLayouts.eurkey_down = {
    description = "Eurkey layout shifted down - layer 3 and 4 are moved down to layer 1 and 2.";
    languages = [ "eng" "fr" ];
    symbolsFile = ./symbols/eurkey_down;
  };
}
