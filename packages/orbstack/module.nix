{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.orbstack;

  defaultDockerConfigDir = "${config.home.homeDirectory}/.docker";

  # Docker CLI plugins shipped inside OrbStack.app
  plugins = [
    "docker-buildx"
    "docker-compose"
  ];
in
{
  meta.maintainers = [ ];

  options.programs.orbstack = {
    enable = lib.mkEnableOption "OrbStack, a Docker and Linux VM runtime for macOS";

    package = lib.mkPackageOption pkgs "orbstack" { };

    dockerConfigDir = lib.mkOption {
      type = lib.types.str;
      default = defaultDockerConfigDir;
      defaultText = lib.literalExpression ''"''${config.home.homeDirectory}/.docker"'';
      example = lib.literalExpression ''"''${config.xdg.configHome}/docker"'';
      description = ''
        Docker CLI configuration directory. OrbStack's bundled CLI plugins
        (buildx, compose) are linked into its {file}`cli-plugins`
        subdirectory, and {env}`DOCKER_CONFIG` is set when it differs from
        the Docker default.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      (lib.hm.assertions.assertPlatform "programs.orbstack" pkgs lib.platforms.darwin)
    ];

    home.packages = [ cfg.package ];

    home.sessionVariables = lib.mkIf (cfg.dockerConfigDir != defaultDockerConfigDir) {
      DOCKER_CONFIG = cfg.dockerConfigDir;
    };

    home.file = lib.genAttrs (map (p: "${cfg.dockerConfigDir}/cli-plugins/${p}") plugins) (path: {
      source = "${cfg.package}/bin/${baseNameOf path}";
    });
  };
}
