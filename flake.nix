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
    onepassword-shell-plugins = {
      url = "github:1Password/shell-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-homebrew,
      onepassword-shell-plugins,
      ...
    }:
    {
      # Empty default shell on every platform; override per-platform below.
      devShells =
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (system: {
          default = nixpkgs.legacyPackages.${system}.mkShellNoCC { };
        })
        // {
          aarch64-darwin.default =
            let
              pkgs = nixpkgs.legacyPackages.aarch64-darwin;
            in
            pkgs.mkShellNoCC {
              packages = [
                (pkgs.writeShellApplication {
                  name = "mkbrewfile";
                  runtimeEnv = {
                    HOMEBREW_NO_AUTO_UPDATE = "1";
                    HOMEBREW_BUNDLE_NO_DESCRIBE = "1";
                    HOMEBREW_BUNDLE_DUMP_NO_VSCODE = "1";
                    HOMEBREW_BUNDLE_DUMP_NO_UV = "1";
                  };
                  text = ''
                    brew bundle dump -f --file "$(git rev-parse --show-toplevel)/hosts/mbp/brew/brewfile.rb"
                  '';
                })
              ];
            };
        };

      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Joshs-MacBook-Pro
      darwinConfigurations."Joshs-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin
          ./hosts/mbp/brew
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = false;
              user = "joshuata";
              autoMigrate = true;
            };
          }
          home-manager.darwinModules.home-manager
          {
            nixpkgs.overlays = [
              (_final: prev: {
                _1password-cli-beta = prev.callPackage ./pkgs/_1password-cli-beta { };
                orbstack_loc = prev.callPackage ./pkgs/orbstack { };
              })
            ];

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.joshuata = import ./hosts/mbp/default.nix;
            home-manager.extraSpecialArgs = { inherit onepassword-shell-plugins; };
            home-manager.backupFileExtension = "bkp";
          }
        ];
        specialArgs = { inherit onepassword-shell-plugins; };
      };
      homeConfigurations."joshuata" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./hosts/adolin ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
      # Per-system home configurations. `home-manager switch --flake .#vscode`
      # resolves via legacyPackages.<currentSystem>, so the same command works
      # on both x86_64-linux and aarch64-linux.
      legacyPackages = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ] (system: {
        homeConfigurations."vscode" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [ ./hosts/adolin ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
      });
    };
}
