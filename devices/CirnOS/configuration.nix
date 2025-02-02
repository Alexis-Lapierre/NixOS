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
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices.crypt_backup.device = "/dev/disk/by-uuid/f1b9596c-38de-4c45-b7d0-18db7e0f192a";
  };
  fileSystems."/backup" =
    { device = "/dev/disk/by-uuid/95e50237-42eb-4ae2-be87-ac88b5e986f0";
      fsType = "ext4";
    };

  networking.hostName = "CirnOS"; # Define your hostname.

  # No need for printer here.
  services.printing.enable = false;

  AlexisLapierre = {
    cosmicEpoch.enable = true;
    games.steam.enable = true;
    home-manager.enable = true;

    programming = {
      exercism.enable = true;
      rust.enable = true;
    };
  };
  

  hardware = {
    # TODO: check if Keychron Q10 work with the following:
    # keyboard.qmk.enable = true;
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };

    # driving wheel drivers for the Logitech G923
    new-lg4ff.enable = true;
  };

  # oversteer for managing the driving wheel
  services.udev.packages = [ pkgs.oversteer ];
  # oups, the stable version does not compile :(
  # users.users.${username}.packages = [ pkgs.oversteer ];

  users.users.${username} = {
    description = "Cirno";
    packages = [ pkgs.brave ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
