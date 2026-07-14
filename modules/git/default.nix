{
  programs = {
    git = {
      enable = true;
      signing.format = "openpgp";
      settings = {
        user = {
          name = "Josh Asplund";
          email = "joshasplund@gmail.com";
        };
        alias = {
          fpush = "push --force-with-lease";
        };
        init.defaultBranch = "main";
        push.default = "simple";
        pull.rebase = "true";
        merge.conflictStyle = "zdiff3";
        status.showUntrackedFiles = "all";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  xdg.configFile = {
    "git/ignore" = {
      text = builtins.readFile ./gitignore_global;
    };
  };
}
