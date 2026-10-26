{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs
    pnpm
  ];

  # Keep npm and the node REPL out of $HOME.
  home.sessionVariables = {
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
    NODE_REPL_HISTORY = "${config.xdg.stateHome}/node_repl_history";
  };
}
