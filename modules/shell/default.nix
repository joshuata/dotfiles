{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs = {
    zoxide.enable = true;
    starship = {
      enable = true;
      settings = builtins.fromTOML (builtins.readFile ./starship.toml);
    };
    atuin = {
      enable = true;
      settings = {
        enter_accept = false;
        inline_height = 20;
      };
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      completionInit = "autoload -U compinit && compinit -d \"${config.xdg.cacheHome}/zsh/zcompdump\"";
      plugins = [
        {
          name = "iterm2-shell-integration";
          src = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/gnachman/iTerm2-shell-integration/9f4ee84236dca4cd27ad9b208be4effd0bf7e8e7/shell_integration/zsh";
            sha256 = "eF8Y4gPCnI0Gqc03TQgxdIkJ9cYUMXUoeBd2RoH4QKc=";
          };
        }
      ];
      history = {
        append = true;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      initContent = lib.mkOrder 1200 (builtins.readFile ./zshconfig.zsh);
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
  };

  home.shell.enableShellIntegration = true;
}
