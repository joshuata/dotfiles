{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    jetbrains-toolbox
  ];

  home.sessionPath = [
    "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
  ];
}
