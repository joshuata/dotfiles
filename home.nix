{ config, pkgs, ... }:

{
  home = {
    username = "vscode";
    homeDirectory = "/home/vscode";
    # shell = pkgs.zsh;
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    nil
    nixfmt-rfc-style
  ];

  programs = {
    git = {
      enable = true;
      delta.enable = true;
      userEmail = "joshasplund@gmail.com";
      userName = "Josh Asplund";
      aliases = {
        fpush = "push --force-with-lease";
      };
      extraConfig = {
        init.defaultBranch = "main";
        push.default = "simple";
        pull.rebase = "true";
        merge.conflictStyle = "zdiff3";
        status.showUntrackedFiles = "all";
      };
    };
    zoxide.enable = true;
    starship = {
      enable = true;
      settings = builtins.fromTOML (builtins.readFile ./config/starship.toml);
    };
    atuin = {
      enable = true;
      settings = {
        enter_accept = false;
        inline_height = 20;
      };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      completionInit = "autoload -U compinit && compinit -d \"${config.xdg.cacheHome}/zsh/zcompdump\"";
      history = {
        append = true;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      initContent = ''
        alias -s git="git clone"
      '';
    };
    tmux = {
      enable = true;
      prefix = "C-a";
      terminal = "tmux-256color";
      keyMode = "vi";
      plugins = with pkgs.tmuxPlugins; [
        vim-tmux-navigator
        catppuccin
        yank
      ];
      extraConfig = ''
        bind C-l send-keys 'C-l'
      '';
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      # settings = {
      #   background = "dark";
      #   history = 1000;
      #   number = true;
      #   modeline = true;
      # };
      extraConfig = builtins.readFile ./config/baseinit.vim;
      plugins = with pkgs.vimPlugins; [
        yankring
        vim-nix
        catppuccin-nvim
        ctrlp
        editorconfig-nvim
        vim-tmux-navigator
        vim-indent-guides
        fzf-vim
      ];
    };
  };

  xdg.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
