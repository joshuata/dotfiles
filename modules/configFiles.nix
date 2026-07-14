{
  config,
  ...
}:
{
  xdg.configFile = {
    "git/ignore" = {
      text = builtins.readFile ../config/gitignore_global;
    };
    "python/pythonrc" = {
      text = builtins.readFile ../config/pythonrc;
    };
  };

  home.sessionVariables = {
    PYTHONSTARTUP = "${config.xdg.configFile."python/pythonrc".target}";
  };
}
