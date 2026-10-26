{ inputs }:
let
  inherit (inputs) nixpkgs nix-darwin home-manager;
in
{
  # A nix-darwin system. `hostname` must match `scutil --get LocalHostName`
  # so `darwin-rebuild switch --flake .` picks this configuration.
  # `modules` are nix-darwin modules; `home` are home-manager modules for
  # `username`. The state versions record when the machine was first set up;
  # read the release notes before changing them.
  mkDarwin =
    {
      hostname,
      username,
      system ? "aarch64-darwin",
      stateVersion ? 4,
      homeStateVersion ? "24.11",
      modules ? [ ],
      home ? [ ],
    }:
    nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ../modules/darwin
        {
          nixpkgs.hostPlatform = system;
          networking.localHostName = hostname;
          system.primaryUser = username;
          system.stateVersion = stateVersion;
          home-manager.users.${username} = {
            imports = home;
            home.stateVersion = homeStateVersion;
          };
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
      stateVersion ? "24.11",
      modules,
    }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { inherit system; };
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ../modules/home/standalone.nix
        {
          home = {
            inherit username homeDirectory stateVersion;
          };
        }
      ]
      ++ modules;
    };
}
