{ pkgs, username }:
{
  virtualisation.podman.enable = true;
  users.users.${username} = {
    packages = [
      pkgs.toolbox
    ];
  };
}
