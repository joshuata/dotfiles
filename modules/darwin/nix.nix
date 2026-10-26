# The Nix daemon: Lix, binary caches, trusted users and garbage collection.
{ config, pkgs, ... }:
{
  imports = [ ../shared/nix.nix ];

  ids.gids.nixbld = 350;

  nix = {
    package = pkgs.lixPackageSets.latest.lix;

    settings.trusted-users = [
      "root"
      config.system.primaryUser
      "@admin"
    ];
    # Flakes only: drops /nix/var/nix/profiles/per-user/root/channels from NIX_PATH.
    # nixpkgs=flake:nixpkgs is still added by nixpkgs.flake.setNixPath.
    channel.enable = false;
    settings.extra-substituters = [
      "https://cache.lix.systems"
      "https://nix-community.cachix.org"
    ];
    settings.extra-trusted-public-keys = [
      "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    gc.automatic = true;
  };

  # Nix tools built against Lix instead of upstream Nix
  nixpkgs.overlays = [
    (final: prev: {
      inherit (prev.lixPackageSets.latest)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    })
  ];
}
