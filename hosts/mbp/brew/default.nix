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

    # masApps = {
    #   "1Password for Safari" = 1569813296;
    #   "Add to Giftster Wish List Registry" = 6736534314;
    #   "Amphetamine" = 937984704;
    #   "Bitwarden" = 1352778147;
    #   "Controller" = 1198176727;
    #   "Hand Mirror" = 1502839586;
    #   "Home Assistant" = 1099568401;
    #   "Mela" = 1568924476;
    #   "MindNode Next" = 6446116532;
    #   "MusicBox" = 1614730313;
    #   "Parcel" = 375589283;
    #   "Peek" = 1554235898;
    #   "PiPifier" = 1160374471;
    #   "Pixelmator Pro" = 1289583905;
    #   "Reeder" = 1529448980;
    #   "Save to Raindrop.io" = 1549370672;
    #   "Tailscale" = 1475387142;
    #   "Velja" = 1607635845;
    #   "Windows App" = 1295203466;
    #   "Wipr" = 1662217862;
    # };
  };
}
