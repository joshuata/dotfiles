{
  description = "OrbStack package and home-manager module";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs [ "aarch64-darwin" "x86_64-darwin" ] (
          system:
          f (
            import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            }
          )
        );
    in
    {
      packages = forAllSystems (pkgs: rec {
        orbstack = pkgs.callPackage ./package.nix { };
        default = orbstack;
      });

      overlays.default = import ./overlay.nix;

      homeManagerModules = rec {
        orbstack = ./home-manager.nix;
        default = orbstack;
      };
    };
}
