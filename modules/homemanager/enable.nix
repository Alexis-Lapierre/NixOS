{ lib, config, unstable, ... }:
{
  options.AlexisLapierre.home-manager = {
    enable = lib.mkEnableOption "Use the home manager on this device";
    user = lib.mkOption {
      default = "cirno";
      example = "alexis_lapierre";
      description = "Username to use home manager on";
      type = lib.types.str;
    };
  };

  config = lib.mkIf config.AlexisLapierre.home-manager.enable {
    home-manager.users.${config.AlexisLapierre.home-manager.user} = (import ./home.nix ({ unstable = unstable; }));
  };
}
