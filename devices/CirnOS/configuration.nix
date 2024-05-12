# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, unstable, ... }:
let
  username = "cirno";
in {
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../common.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "CirnOS"; # Define your hostname.

  # Configure keymap in X11
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
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
  
  environment.systemPackages = [
    pkgs.timeshift # Backups!
  ];

  users.users.${username} = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Cirno";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # nix helper, still don't know if I'll keep it
      unstable.nh

      # Web browsers I use often
      firefox
      brave

      # Gnome needs gnome tweaks to access some settings
      gnome.gnome-tweaks

      # My prefered terminal emulator
      unstable.kitty

      # clipboard for helix
      wl-clipboard
      unstable.xclicker

      # My programming needs 
      unstable.gitui
      androidStudioPackages.canary

      # tty commands I use
      unstable.eza
      unstable.zoxide
      bat
      neofetch

      # Image management
      unstable.hydrus

      # Viewing my epub files
      okular

      # Communication with friends
      discord
      telegram-desktop

      # Gaming!
      # run (in this case) visual novels via steam run
      steam-run
      # Other random video games I have collected require wine
      # Force wayland with wine 32 bits because I like wayland
      wineWowPackages.waylandFull
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
