# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:
let
  username = "cirno";
in {
  imports = [
      ./hardware-configuration.nix
      ../../modules/common.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "CirnOS"; # Define your hostname.

  # No need for printer here.
  services.printing.enable = false;

  AlexisLapierre = {
    cosmicEpoch.enable = true;
    games.steam.enable = true;
  };
  
  environment.systemPackages = [
    pkgs.timeshift # Backups!
  ];

  hardware = {
    # TODO: check if Keychron Q10 work with the following:
    # keyboard.qmk.enable = true;
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };

  users.users.${username} = {
    description = "Cirno";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
