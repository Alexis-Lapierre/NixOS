{ pkgs, unstable, username }:
{
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

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "fr";
    xkbVariant = "us";

    # do not use the xterm terminal
    excludePackages = [ pkgs.xterm ]; 
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
  # GnuPGP settings, I guess ?
  programs.git.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  users.users.${username} = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      brave
      
      # a great nix helper
      unstable.nh

      # My prefered terminal emulator
      unstable.kitty
      
      # clipboard for helix
      wl-clipboard


      # My programming needs 
      unstable.gitui

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
      telegram-desktop

      # Archive extraction, woo
      p7zip
    ];
  };
}
