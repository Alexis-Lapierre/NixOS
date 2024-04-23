# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, unstable, ... }:
let
  username = "cirno";
in {
  imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (final: prev: {
    hydrus = prev.hydrus.overrideAttrs ( old: {
      version = "571";
      src = prev.fetchFromGitHub {
        owner = "hydrusnetwork";
        repo = "hydrus";
        rev = "refs/tags/v${final.hydrus.version}";
        sha256 = "sha256-e4IfE/XS0egXNrEsDXQi9JvJpY4iCw59+KN0YSi35dk=";
      };
    });
  }) ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "CirnOS"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Locale
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "fr";
    xkbVariant = "us";
    xkbOptions = "caps:swapescape";

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # do not use the xterm terminal
    excludePackages = [ pkgs.xterm ]; 
  };

  # enable auto login for main user + workaround found here:
  # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = username;
  };

  # Configure console keymap
  console.keyMap = "us";

  # No need for printer here.
  services.printing.enable = false;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

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
      hydrus
      (pkgs.callPackage ./hydrus-desktop.nix {})

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

  # allow me to use nix command directly
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment = {
    gnome.excludePackages = with pkgs; [
      geany # I use helix 
      gnome.epiphany # I use firefox
      gnome.geary # No need for an email client
      gnome.gnome-terminal # I use kitty
    ];

    # do not use gnome terminal or epiphany (web browser)
    systemPackages = with pkgs; [
      unstable.helix # My editor, latest version
      nil # Nix language server, used by helix

      timeshift

      # Some tools I use often
      htop
      file # standard utils tool
      ethtool
      killall
    ];

    # Since there is no programs.helix.defaultEditor, just plainly force this value for everyone
    # A redditor seemed really mad about this
    variables.EDITOR = "hx";
  };

  programs.fish.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # GnuPGP settings, I guess ?
  programs.git.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
