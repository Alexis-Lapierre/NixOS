{ pkgs, unstable, ... }: {
  home.username = "cirno";
  home.homeDirectory = "/home/cirno";
  home.stateVersion = "24.05";

  programs.git = {
    enable = true;
    userName  = "Alexis Lapierre";
    userEmail = "128792625+Alexis-Lapierre@users.noreply.github.com";
    aliases = {
      b = "branch";
      bD = "branch -D";
      bd = "branch --delete";
      c = "checkout";
      fp = "fetch -p";
      pushf = "push --force-with-lease";
      s = "switch --create";
      st = "status";
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
    package = unstable.zoxide;
    enableFishIntegration = true;
  };

  programs.helix = {
    enable = true;
    package = unstable.helix;
    defaultEditor = true;
    settings = {
      theme = "cat_trans";
      editor = {
        auto-pairs = false;
        bufferline = "multiple";
        color-modes = true;
        soft-wrap.enable = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          cursor-line = "warning";
          other-lines = "warning";
        };
      };
      keys.normal = {
        X = [ "extend_line_up" "extend_to_line_bounds" ];
      };
    };

    languages = {
      language-server.harper-ls = {
        command = "${unstable.harper}/bin/harper-ls";
        args = [ "--stdio" ];
      };
      language = [{
        name = "rust";
        language-servers = [ "rust-analyzer" "harper-ls" ];
      } {
        name = "git-commit";
        language-servers = [ "harper-ls" ];
      }];
    };

    themes.cat_trans = {
      inherits = "catppuccin_mocha";
      "ui.background" = "default";
    };
  };

  programs.kitty = {
    enable = true;
    package = unstable.kitty;
    settings = {
      font_family = "ComicCodeLigatures Nerd Font";
      confirm_os_window_close = 1;
      tab_bar_edge  = "top";
      tab_bar_style = "slant";
      copy_on_select = "yes";
      background_opacity = "0.7";
      editor = "hx";
    };
    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
      "ctrl+alt+t" = "set_tab_title";
      "ctrl+shift+;" = "next_layout";
      "alt+h" = "neighboring_window left";
      "alt+l" = "neighboring_window right";
      "alt+k" = "neighboring_window up";
      "alt+j" = "neighboring_window down";
      "ctrl+shift+h" = "previous_tab";
      "ctrl+shift+l" = "next_tab";
      "alt+shift+h" = "move_tab_backward";
      "alt+shift+l" = "move_tab_forward";
      # This is annoying, I keep hitting it by mistake
      "ctrl+shift+w" = "no_op";
    };
  };
}
