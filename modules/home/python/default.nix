{ config, ... }:
{
  xdg.configFile."python/pythonrc".source = ./pythonrc;

  home.sessionVariables = {
    PYTHONSTARTUP = "${config.xdg.configHome}/python/pythonrc";
  };
}
