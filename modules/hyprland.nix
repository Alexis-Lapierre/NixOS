{ pkgs, unstable, username }:
{
  users.users.${username} = {
    packages = with pkgs; [
      waybar
      pavucontrol
      wofi
      hyprshot
    ];
  };
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
