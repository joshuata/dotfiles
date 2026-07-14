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
      plugins = [
        {
          name = "iterm2-shell-integration";
          src = pkgs.fetchurl {
            url = "https://iterm2.com/shell_integration/zsh";
            sha256 = "kQJ8bVIh7nEjYJ6OWqiEDqIY+YWD5RbD1CXV+KKyDno=";
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
