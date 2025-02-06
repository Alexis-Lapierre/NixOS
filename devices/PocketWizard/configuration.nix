{ pkgs, ... }:
let
  username = "cirno";
in {
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/common.nix
  ];

  AlexisLapierre = {
    eurkey_down.enable = true;
    home-manager.enable = true;
    programming.rust.enable = true;
  };

  # Bootloader.
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "PocketWizard"; # Define your hostname.

  # No need for printer here.
  services = {
    printing.enable = true;
    printing.drivers = [ pkgs.gutenprint ];

    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  environment.systemPackages = with pkgs; [
    maliit-keyboard # virtual keyboard on tablet mode
    wl-clipboard
  ];


  users.users.${username} = {
    description = "Cirno";
    packages = with pkgs; [ krita ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
