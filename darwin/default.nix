{
  pkgs,
  ...
}:
{
  imports = [
    ./hammerspoon.nix
  ];

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  ids.gids.nixbld = 350;

  nix = {
    # Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";
    settings.trusted-users = [
      "root"
      "joshuata"
      "@admin"
    ];
    settings.extra-nix-path = "nixpkgs=flake:nixpkgs";
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

  nix.linux-builder = {
    enable = true;
    ephemeral = true;
    maxJobs = 4;
    config = {
      virtualisation = {
        darwin-builder = {
          diskSize = 40 * 1024;
          memorySize = 8 * 1024;
        };
        cores = 6;
      };
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  programs.fish.enable = true;

  # security.pam.services.sudo_local.watchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.segger-jlink.acceptLicense = true;

  system.primaryUser = "joshuata";
  users.users.joshuata = {
    name = "joshuata";
    home = "/Users/joshuata";
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    cascadia-code
    jetbrains-mono
    meslo-lgs-nf
    monaspace
  ];
}
