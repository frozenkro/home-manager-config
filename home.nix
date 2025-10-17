{ config, pkgs, ... }:

let 
  username = builtins.getEnv "USER";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    #pkgs.oh-my-zsh
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink ./nvim;
    };
    ".config/hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink ./hypr;
    };
    ".config/waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink ./waybar;
    };
    ".config/ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink ./ghostty;
    };
    ".config/kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink ./kitty;
    };
    ".config/wofi" = {
      source = config.lib.file.mkOutOfStoreSymlink ./wofi;
    };
    # ".oh-my-zsh" = {
    #   source = config.lib.file.mkOutOfStoreSymlink ./zsh/.oh-my-zsh;
    # };
    # ".p10k.zsh" = {
    #   source = config.lib.file.mkOutOfStoreSymlink ./zsh/.p10k.zsh;
    # };
    ".zshrc" = {
      source = config.lib.file.mkOutOfStoreSymlink ./zsh/.zshrc;
    };
    ".zshenv" = {
      source = config.lib.file.mkOutOfStoreSymlink ./zsh/.zshenv;
    };
    ".wezterm.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink ./wezterm/.wezterm.lua;
    };
    # ".dir_colors" = {
    #   source = config.lib.file.mkOutOfStoreSymlink ./zsh/.dir_colors;
    # };
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kaleb/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "ghostty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.wofi.enable = true;
  # programs.zsh = {
  #   enable = true;
  #   autosuggestion.enable = true;
  #   syntaxHighlighting.enable = true;
  #   shellAliases = {
  #     buildNix = "nixos-rebuild switch --flake \"$(readlink -f /etc/nixos)\"#default";
  #     buildHm = "home-manager switch";
  #   };
  #   oh-my-zsh = {
  #     enable = true;
  #     theme = "powerlevel10k/powerlevel10k";
  #     plugins = [
  #       "git"
  #       "vi-mode"
  #       "docker"
  #     ];
  #   };

  #   plugins = [
  #     {
  #       name = "powerlevel10k";
  #       src = pkgs.zsh-powerlevel10k;
  #       file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  #     }
  #     # {
  #     #   name = "powerlevel10k-config";
  #     #   src = ./zsh;
  #     #   file = "p10k.zsh";
  #     # }
  #   ];

  #   initExtra = ''
  #     if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
  #       source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
  #     fi

  #     [[ ! -f !/.p10k.zsh ]] || source !/.p10k.zsh

  #   '';
  # };
}
