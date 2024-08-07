{ pkgs, username }:
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
      qt6ct # Set your Qt themes with this application
    ];
  };
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
