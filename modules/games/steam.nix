{ pkgs, unstable, username }:
{
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };

  users.users.${username} = {
    packages = with pkgs; [
      # Gaming!
      # run (in this case) visual novels via steam run
      steam-run

      # Not really steam related, but oh well…
      # Other random video games I have collected require wine
      # Force wayland with wine 32 bits because I like wayland
      wineWowPackages.waylandFull
      # StarSector is a good game
      unstable.starsector
      # Minecrap !
      unstable.prismlauncher
    ];
  };
}
