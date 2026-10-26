{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.homebrew;

  # Extract the names from Brewfile lines of the given type,
  # e.g. `cask "1password"` or `tap "1password/tap", trusted: true`.
  parseBrewfile =
    type:
    lib.pipe (builtins.readFile cfg.importBrewfile) [
      (lib.splitString "\n")
      (map (builtins.match "[[:space:]]*${type}[[:space:]]+\"([^\"]+)\".*"))
      (lib.filter (m: m != null))
      (map builtins.head)
    ];
in
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  options.homebrew.importBrewfile = lib.mkOption {
    type = lib.types.nullOr lib.types.path;
    default = null;
    description = "Brewfile whose taps, casks and brews are installed via Homebrew.";
  };

  config = lib.mkIf (cfg.importBrewfile != null) {
    environment.systemPackages = with pkgs; [
      mas
      (callPackage ../../packages/mkbrewfile {
        brewfile = lib.removePrefix "${inputs.self}/" (toString cfg.importBrewfile);
      })
    ];

    nix-homebrew = {
      enable = true;
      user = config.system.primaryUser;
      autoMigrate = true;
    };

    homebrew = {
      enable = true;
      taps = parseBrewfile "tap";
      casks = parseBrewfile "cask";
      brews = parseBrewfile "brew";

      onActivation = {
        autoUpdate = true;
        upgrade = true;
        # cleanup = "zap";
      };
    };
  };
}
