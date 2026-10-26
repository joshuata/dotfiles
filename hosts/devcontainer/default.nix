{
  imports = [
    ../../profiles/base.nix
  ];

  home.sessionVariables = {
    EDITOR = "code";
  };

  programs = {
    vim = {
      defaultEditor = false;
    };
  };
}
