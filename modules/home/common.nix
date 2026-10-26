{
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  xdg.enable = true;
  xdg.userDirs.createDirectories = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
