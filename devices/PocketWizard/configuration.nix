{ pkgs, unstable, ... }:
let
  username = "cirno";
in {
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import ../../modules/common.nix ({ pkgs = pkgs; unstable = unstable; username = username; }))
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "PocketWizard"; # Define your hostname.

  # No need for printer here.
  services.printing.enable = false;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  environment.systemPackages = [
    pkgs.wl-clipboard
  ];


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
