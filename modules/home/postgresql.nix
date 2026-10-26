{ config, pkgs, ... }:
{
  home.packages = [ pkgs.postgresql ];

  home.sessionVariables = {
    PSQL_HISTORY = "${config.xdg.stateHome}/psql_history";
    PGSERVICEFILE = "${config.xdg.configHome}/pg/pg_service.conf";
  };
}
