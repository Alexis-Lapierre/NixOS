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

  programs.fish = {
    enable = true;
    shellAbbrs = {
      ":q" = "exit";
      cd = "z";
      gg = "git grep -In";
      groot = "cd \(git rev-parse --show-toplevel\)";
      la = "exa --all --git --icons --long --group";
      ls = "exa --git --icons --long --group";
      icat = "kitty +kitten icat --align=center";
      ssh = "kitty +kitten ssh";
      cat = "bat";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
