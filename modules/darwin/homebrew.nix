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

  # Taps keep their `trusted: true` flag, which nix-darwin re-emits in its Brewfile.
  parseTaps = lib.pipe (builtins.readFile cfg.importBrewfile) [
    (lib.splitString "\n")
    (map (builtins.match "[[:space:]]*tap[[:space:]]+\"([^\"]+)\"(.*)"))
    (lib.filter (m: m != null))
    (map (m: {
      name = builtins.elemAt m 0;
      trusted = builtins.match ".*trusted:[[:space:]]*true.*" (builtins.elemAt m 1) != null;
    }))
  ];

  # Mac App Store apps, e.g. `mas "Amphetamine", id: 937984704` -> { Amphetamine = 937984704; }.
  parseMas = lib.pipe (builtins.readFile cfg.importBrewfile) [
    (lib.splitString "\n")
    (map (
      builtins.match "[[:space:]]*mas[[:space:]]+\"([^\"]+)\",[[:space:]]*id:[[:space:]]*([0-9]+).*"
    ))
    (lib.filter (m: m != null))
    (map (m: lib.nameValuePair (builtins.elemAt m 0) (lib.toInt (builtins.elemAt m 1))))
    lib.listToAttrs
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

    # mas >= 7 re-runs itself via /usr/bin/sudo to install App Store apps, which
    # can't prompt during `darwin-rebuild` (brew bundle installing masApps).
    # Only the root-owned Nix store copy is allowed; never a /opt/homebrew path,
    # which is user-writable. mas forwards MAS_NO_AUTO_INDEX through sudo, so
    # that one variable must be allowed too.
    security.sudo.extraConfig = lib.mkIf (parseMas != { }) ''
      Cmnd_Alias NIX_MAS = ${pkgs.mas}/bin/mas, ${pkgs.mas}/libexec/bin/mas
      Defaults!NIX_MAS env_keep += "MAS_NO_AUTO_INDEX"
      ${config.system.primaryUser} ALL=(root) NOPASSWD: NIX_MAS
    '';

    nix-homebrew = {
      enable = true;
      user = config.system.primaryUser;
      autoMigrate = true;
    };

    homebrew = {
      enable = true;
      taps = parseTaps;
      casks = parseBrewfile "cask";
      brews = parseBrewfile "brew";
      # `brew bundle` finds `mas` because nix-darwin adds pkgs.mas to its PATH.
      masApps = parseMas;

      onActivation = {
        # Updated in a separate step below instead: brew's auto-update re-execs
        # its wrapper, which drops pkgs.mas from the PATH that `brew bundle`
        # searches, so bundle would `brew install mas` behind our back.
        autoUpdate = false;
        upgrade = true;
        cleanup = "uninstall";
      };
    };

    # Runs after nix-homebrew's prefix setup (mkBefore) and before `brew bundle`.
    system.activationScripts.homebrew.text = lib.mkOrder 750 ''
      echo >&2 "Homebrew update..."
      if [ -f "${config.homebrew.prefix}/bin/brew" ]; then
        sudo --user=${lib.escapeShellArg config.system.primaryUser} --set-home \
          ${config.homebrew.prefix}/bin/brew update \
          || echo >&2 "warning: brew update failed; continuing with cached Homebrew data"
      fi
    '';
  };
}
