{ lib, pkgs, ... }:
let
  # Extract the names from Brewfile lines of the given type,
  # e.g. `cask "1password"` or `tap "1password/tap", trusted: true`.
  parseBrewfile =
    type:
    lib.pipe (builtins.readFile ./brewfile.rb) [
      (lib.splitString "\n")
      (map (builtins.match "[[:space:]]*${type}[[:space:]]+\"([^\"]+)\".*"))
      (lib.filter (m: m != null))
      (map builtins.head)
    ];
in
{
  environment.systemPackages = with pkgs; [
    mas
  ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # cleanup = "zap";
    };

    taps = parseBrewfile "tap";
    casks = parseBrewfile "cask";
    brews = parseBrewfile "brew";
  };
}
