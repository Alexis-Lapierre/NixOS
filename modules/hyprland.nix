{ pkgs, unstable, username }:
{
  users.users.${username} = {
    packages = with pkgs; [
      hyprpaper # set a wallpaper on hyprland
      hyprshot # screenshot tool on wayland
      mako # notifications
      pavucontrol # volume controls
      waybar # Top bar
      wl-clipboard # clipboard for terminal based app
      wofi # app launcher
    ];
  };
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
