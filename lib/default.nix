{ inputs }:
let
  inherit (inputs) nixpkgs nix-darwin home-manager;
in
{
  # A nix-darwin system. `hostname` must match `scutil --get LocalHostName`
  # so `darwin-rebuild switch --flake .` picks this configuration.
  mkDarwin =
    {
      hostname,
      username,
      system ? "aarch64-darwin",
      modules,
    }:
    nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ../modules/darwin
        {
          nixpkgs.hostPlatform = system;
          networking.localHostName = hostname;
          system.primaryUser = username;
        }
      ]
      ++ modules;
    };

  # A standalone (non-darwin) home-manager configuration.
  mkHome =
    {
      username,
      homeDirectory ? "/home/${username}",
      system,
      modules,
    }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { inherit system; };
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ../modules/home/standalone.nix
        { home = { inherit username homeDirectory; }; }
      ]
      ++ modules;
    };
}
