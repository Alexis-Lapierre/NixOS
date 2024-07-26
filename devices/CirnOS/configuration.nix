# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, unstable, ... }:
let
  username = "cirno";
in {
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import ../../modules/common.nix ({ pkgs = pkgs; unstable = unstable; username = username; }))
      (import ../../modules/hyprland.nix ({ pkgs = pkgs; unstable = unstable; username = username; }))
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "CirnOS"; # Define your hostname.

  # Configure keymap in X11
  services.xserver = {
    # I use a QWERTY keyboard at this compture, so US keyboard with french characteristics.
    layout = "fr";
    xkb = {
      layout = "fr";
      variant = "us";
    };
  };

  # No need for printer here.
  services.printing.enable = false;
  
  environment.systemPackages = [
    pkgs.timeshift # Backups!
  ];

  users.users.${username} = {
    description = "Cirno";
    packages = with pkgs; [
      unstable.xclicker

      # copy paste in x11
      xsel

      # Gaming!
      # run (in this case) visual novels via steam run
      steam-run
      # Other random video games I have collected require wine
      # Force wayland with wine 32 bits because I like wayland
      wineWowPackages.waylandFull
      # StarSector is a good game
      unstable.starsector
      # Minecrap !
      unstable.prismlauncher
    ];
  };

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
