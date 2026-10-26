# Nix settings shared by nix-darwin and standalone home-manager; both expose
# the same `nix.settings` option.
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
