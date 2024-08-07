{ pkgs, username }:
{
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
  };
  users.users.${username} = {
    packages = with pkgs; [
      wofi # Used in a shortcut
    ];
  };
}
