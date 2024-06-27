{ pkgs, unstable, username }:
{
  users.users.${username} = {
    packages = with pkgs; [
      waybar
      pavucontrol
      wofi
      hyprshot
      hyprpaper
    ];
  };
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
