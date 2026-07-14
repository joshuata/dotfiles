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
  };
}
