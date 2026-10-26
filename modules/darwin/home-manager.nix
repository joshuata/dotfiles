# home-manager as a nix-darwin module; per-user config comes from mkDarwin's `home`.
{ pkgs, inputs, ... }:
{
  imports = [ inputs.home-manager.darwinModules.home-manager ];

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

  environment.systemPackages = [ pkgs.home-manager ];
}
