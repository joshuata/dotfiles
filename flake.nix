{
  description = "joshuata system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs) lib;
      inherit (import ./lib { inherit inputs; }) mkDarwin mkHome;

      systems = [
        "aarch64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
    in
    {
      # `nix fmt` formats the whole repo.
      formatter = lib.genAttrs systems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);

      # `nix flake check` builds every configuration for the current system.
      # Add new machines' configurations under their system here.
      checks =
        let
          darwin = lib.mapAttrs' (
            n: c: lib.nameValuePair "darwin-${n}" c.config.system.build.toplevel
          ) self.darwinConfigurations;
          home = lib.mapAttrs' (n: c: lib.nameValuePair "home-${n}" c.activationPackage);
        in
        {
          aarch64-darwin = darwin;
          x86_64-linux =
            home self.homeConfigurations // home self.legacyPackages.x86_64-linux.homeConfigurations;
          aarch64-linux = home self.legacyPackages.aarch64-linux.homeConfigurations;
        };

      # Keyed by hostname, which must match `scutil --get LocalHostName`.
      # Apply with: $ sudo darwin-rebuild switch --flake .
      darwinConfigurations = lib.mapAttrs (hostname: args: mkDarwin (args // { inherit hostname; })) {
        "Joshs-MacBook-Pro" = {
          username = "joshuata";
          modules = [ ./hosts/mbp ];
          home = [ ./hosts/mbp/home.nix ];
        };
      };

      homeConfigurations."joshuata" = mkHome {
        username = "joshuata";
        homeDirectory = "/mnt/ssd/home/joshuata";
        system = "x86_64-linux";
        modules = [ ./hosts/adolin ];
      };
      # Per-system home configurations. `home-manager switch --flake .#vscode`
      # resolves via legacyPackages.<currentSystem>, so the same command works
      # on both x86_64-linux and aarch64-linux.
      legacyPackages = lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (system: {
        homeConfigurations."vscode" = mkHome {
          username = "vscode";
          inherit system;
          modules = [ ./hosts/devcontainer ];
        };
      });
    };
}
