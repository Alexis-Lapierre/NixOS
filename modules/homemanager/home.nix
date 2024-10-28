{ ... }: {
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
      rat = "bat";
    };

    functions.fish_prompt = ''
      #Save the return status of the previous command
      set -l last_pipestatus $pipestatus
      set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

      if functions -q fish_is_root_user; and fish_is_root_user
          printf '%s@%s %s%s%s# ' $USER (prompt_hostname) (set -q fish_color_cwd_root
                                                           and set_color $fish_color_cwd_root
                                                           or set_color $fish_color_cwd) \
              (prompt_pwd) (set_color normal)
      else
          set -l status_color (set_color $fish_color_status)
          set -l statusb_color (set_color --bold $fish_color_status)
          set -l pipestatus_string (__fish_print_pipestatus [ ] \| "$status_color" "$statusb_color" $last_pipestatus)

          printf '[%s] %s@%s %s %s %s\n> ' \
              (date "+%H:%M:%S") \
              (set_color aa1fef)$USER(set_color white) \
              (set_color 1fefaa)(prompt_hostname)(set_color efaa1f) \
              (prompt_pwd) \
              $pipestatus_string \
              (set_color normal)
      end
    '';
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
