# Shell, editor and git setup wanted on every machine.
{
  imports = [
    ../modules/home/common.nix
    ../modules/home/mise.nix
    ../modules/home/vim
    ../modules/home/git
    ../modules/home/shell
  ];
}
