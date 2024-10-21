{ pkgs, unstable, ... }:
let
  username = "cirno";
in {
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import ../../modules/common.nix ({ pkgs = pkgs; unstable = unstable; username = username; }))
      (import ../../modules/cosmic-epoch.nix ({  pkgs = pkgs; username = username; }))
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "PocketWizard"; # Define your hostname.

  # No need for printer here.
  services.printing.enable = false;
  
  users.users.${username} = {
    description = "Cirno";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
