# Dumps the installed Homebrew packages into `brewfile`, a path relative to
# the root of the git repo the command is run from.
{ writeShellApplication, brewfile }:
writeShellApplication {
  name = "mkbrewfile";
  runtimeEnv = {
    HOMEBREW_NO_AUTO_UPDATE = "1";
    HOMEBREW_BUNDLE_NO_DESCRIBE = "1";
    HOMEBREW_BUNDLE_DUMP_NO_VSCODE = "1";
    HOMEBREW_BUNDLE_DUMP_NO_UV = "1";
    # go and cargo are mise shims with no global version, so probing them errors
    HOMEBREW_BUNDLE_DUMP_NO_GO = "1";
    HOMEBREW_BUNDLE_DUMP_NO_CARGO = "1";
    BREWFILE = brewfile;
  };
  text = ''
    brew bundle dump -f --file "$(git rev-parse --show-toplevel)/$BREWFILE"
  '';
}
