{ config, pkgs, ... }: {
  home.username = "cirno";
  home.homeDirectory = "/home/cirno";
  home.stateVersion = "24.05";

  programs.git = {
    enable = true;
    userName  = "Alexis Lapierre";
    userEmail = "128792625+Alexis-Lapierre@users.noreply.github.com";
    aliases = {
      pushf = "push --force-with-lease";
      ui = "!gitui";
    };

    extraConfig = {
      branch.sort = "-committerdate";
      init.defaultBranch = "master";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
