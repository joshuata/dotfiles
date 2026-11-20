# System-level (nix-darwin) config for this Mac; user config is in home.nix.
{
  imports = [ ./bambuddy.nix ];

  homebrew.importBrewfile = ./brewfile.rb;
}
