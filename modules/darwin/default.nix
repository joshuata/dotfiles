{
  config,
  pkgs,
  inputs,
  ...
}:
let
  user = config.system.primaryUser;
in
{
  imports = [
    ./homebrew.nix
    inputs.home-manager.darwinModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "bkp";
    sharedModules = [
      {
        # Copy .app bundles instead of symlinking so Spotlight/Raycast index them
        targets.darwin = {
          copyApps.enable = true;
          linkApps.enable = false;
        };
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  ids.gids.nixbld = 350;

  nix = {
    # Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";
    settings.trusted-users = [
      "root"
      user
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

  nix.package = pkgs.lixPackageSets.latest.lix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  programs.fish.enable = true;

  # security.pam.services.sudo_local.watchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.segger-jlink.acceptLicense = true;

  users.users.${user} = {
    name = user;
    home = "/Users/${user}";
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    cascadia-code
    jetbrains-mono
    meslo-lgs-nf
    monaspace
  ];
}
