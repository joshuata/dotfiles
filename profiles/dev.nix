# base plus general development tooling.
{
  imports = [
    ./base.nix
    ../modules/home/devtools.nix
    ../modules/home/nixdev.nix
    ../modules/home/python
    ../modules/home/aws
  ];
}
