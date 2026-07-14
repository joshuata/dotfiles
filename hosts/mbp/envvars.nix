{
  config,
  ...
}:

{
  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    NPM_CONFIG_INIT_MODULE = "${config.xdg.configHome}/npm/config/npm-init.js";
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";

    ANSIBLE_HOME = "${config.xdg.configHome}/ansible";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    VAGRANT_HOME = "${config.xdg.dataHome}/vagrant";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    TS_NODE_HISTORY = "${config.xdg.stateHome}/ts_node_repl_history";
    GOPATH = "${config.xdg.dataHome}/go";
    DOTNET_CLI_HOME = "${config.xdg.dataHome}/dotnet";
    GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
    KREW_ROOT = "${config.xdg.dataHome}/krew";
    NODE_REPL_HISTORY = "${config.xdg.stateHome}/node_repl_history";
    PYENV_ROOT = "${config.xdg.dataHome}/pyenv";
    PSQL_HISTORY = "${config.xdg.stateHome}/psql_history";
    PGSERVICEFILE = "${config.xdg.configHome}/pg/pg_service.conf";
    PLATFORMIO_CORE_DIR = "${config.xdg.dataHome}/platformio";
    NUGET_PACKAGES = "${config.xdg.cacheHome}/NuGetPackages";
  };

}
