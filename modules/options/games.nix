{ lib, config, pkgs, ... }:
{
  options.AlexisLapierre = {
    wine.enable = lib.mkEnableOption "Install Wine: Wayland edition";
    games = {
      steam.enable = lib.mkEnableOption ''
        Install steam with firewall rule and local network game transfers.
      '';
      minecraft = {
        enable = lib.mkEnableOption "Install prism";
        server.allowFirewallRule = lib.mkEnableOption "Allow to host a minecrafter server";
      };
      starsector.enable = lib.mkEnableOption ''
        Install StarSector
      '';
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.AlexisLapierre.wine.enable {
      environment = { systemPackages = with pkgs; [
        # Other random video games I have collected require wine
        # Force wayland with wine 32 bits because I like wayland
        wineWowPackages.waylandFull
      ];};
    })
    (lib.mkIf config.AlexisLapierre.games.steam.enable {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
      environment = { systemPackages = with pkgs; [
        # Gaming!
        # Useful for running visual novels with linux native ports.
        steam-run
      ];};
    })
    (lib.mkIf config.AlexisLapierre.games.minecraft.enable {
      environment = { systemPackages = with pkgs; [
        # Minecrap!
        unstable.prismlauncher
      ];};
    })
    (lib.mkIf config.AlexisLapierre.games.minecraft.server.allowFirewallRule {
      networking.firewall = {
        allowedTCPPorts = [ 25565 ];
      };
    })
    (lib.mkIf config.AlexisLapierre.games.starsector.enable {
      environment = { systemPackages = with pkgs; [
        # StarSector is a good game
        unstable.starsector
      ];};
    })
  ];
}
