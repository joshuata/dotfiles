{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.orbstack;
in
{
  meta.maintainers = [ ];

  options.programs.orbstack = {
    enable = lib.mkEnableOption "orbstack";

    package = lib.mkPackageOption pkgs "orbstack" { };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.sessionVariables.DOCKER_CONFIG = "${config.xdg.configHome}/docker";

    xdg.configFile = lib.genAttrs [ "docker-buildx" "docker-compose" ] (plugin: {
      target = "docker/cli-plugins/${plugin}";
      source = "${cfg.package}/bin/${plugin}";
    });
  };
}
