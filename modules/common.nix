{ pkgs, unstable, ... }:
let
  username = "cirno";
in {
  imports = [
    ./options/default.nix 
    ./homemanager/enable.nix 
  ];

  # /tmp as a temp file system, as expected in other distros
  fileSystems."/tmp" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "mode=777" ];
  };

  # allow me to use nix command directly
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Password feedback, to make my life not miserable when I mistype 
  security.sudo.extraConfig = ''
      Defaults env_reset,pwfeedback
  '';
  
  # Unfree packages, let's go
  nixpkgs.config.allowUnfree = true;

  # Latest kernel because I like it.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # deactivate HTML documentation, I don't use it.
  documentation.nixos.enable = false;

  # Locale, UK english for basic text.
  # French for the rest (€, metric, ...)
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = let
      fr = "fr_FR.UTF-8";
    in {
      LC_ADDRESS = fr;
      LC_IDENTIFICATION = fr;
      LC_MEASUREMENT = fr;
      LC_MONETARY = fr;
      LC_NAME = fr;
      LC_NUMERIC = fr;
      LC_PAPER = fr;
      LC_TELEPHONE = fr;
      LC_TIME = fr;
    };
  };

  services = {
    xserver = {
      # do not use the xterm terminal
      excludePackages = [ pkgs.xterm ]; 
    };
    syncthing = {
        enable = true;
        user = username;
        configDir = "/home/${username}/.config/syncthing";
        openDefaultPorts = true;
    };
  };


  # Configure console keymap
  console.keyMap = "us";

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  fonts.packages = with pkgs; [
    # Being able to display Japaneses and Chinese characters properly is important!
    noto-fonts-cjk-sans
  ];

  environment = {
    systemPackages = with pkgs; [
      unstable.helix # My editor, latest version
      nil # Nix language server, used by helix
      # Some tools I use often
      htop
      file # standard utils tool
      ethtool
      killall
      usbutils # lsusb, youhou
      smartmontools # smartctl command

      wl-clipboard # I always use it, no matter the desktop environment

    ];

    # Since there is no programs.helix.defaultEditor, just plainly force this value for everyone
    # A redditor seemed really mad about this
    variables.EDITOR = "hx";
    sessionVariables = let
      config = "$HOME/.config";
      data = "$HOME/.local/share";
      state = "$HOME/.local/state";
    in {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = data;
      XDG_STATE_HOME = state;
      # Hiding folder away from $HOME:
      HISTFILE = "${state}/bash_history"; # bash history file
      PYTHON_HISTORY = "${state}/python_history"; # python history file

      CARGO_HOME = "${data}/cargo"; # rust compilation
      RUSTUP_HOME = "${data}/rustup";
      GNUPGHOME = "${data}/gnupg"; # commit signing

      RENPY_PATH_TO_SAVES = "${data}/renpy";
      GTK2_RC_FILES = "${config}/gtk-2.0";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot='${config}/java'";
      WINEPREFIX = "${data}/wine";
    };
  };

  programs = {
    fish.enable = true;
    git.enable = true;
    # Signing commits
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  users.users.${username} = {
    description = "Cirno";
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox

      # An image viewer I like
      geeqie
      # a great nix helper
      unstable.nh

      # My prefered terminal emulator
      unstable.kitty
      
      # My programming needs 
      unstable.gitui

      # XDG-open is useful!
      xdg-utils

      # tty commands I use
      unstable.eza
      unstable.zoxide
      bat
      fastfetch
      # Image management
      unstable.hydrus

      # Viewing my epub files
      okular

      # Communication with friends
      discord
      element-desktop
      telegram-desktop

      # Archive extraction, woo
      p7zip

      # Kcharselect is a program that I use often
      kcharselect

      # Password management!
      keepassxc

      # I often use notify-send
      libnotify
    ];
  };
}
