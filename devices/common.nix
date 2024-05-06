{ pkgs, unstable, ... }:
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
}
