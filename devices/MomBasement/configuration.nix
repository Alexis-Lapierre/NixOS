# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, unstable, ... }:
let
  username = "cirno";
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    (import ../common.nix ({ pkgs = pkgs; unstable = unstable; username = username; }))
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "MomBasement";

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure keymap in X11
  services.xserver = {
    # default AZERTY keyboard used at this computer
    xkb = {
      layout = "fr";
      options = "caps:swapescape";
    };


    displayManager.gdm.enable = true;
    desktopManager.lxqt.enable = true;
  };

  # enable auto login for main user + workaround found here:
  # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = username;
  };

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
  system.stateVersion = "23.11"; # Did you read the comment?
}
