# iTerm2 for home-manager

A home-manager module for [iTerm2](https://iterm2.com/): installs the app, loads its shell integration, points it at a preferences folder you keep in git, and writes declarative dynamic profiles. On other platforms (e.g. Linux hosts you SSH into from iTerm2) it only sets up the shell integration.

## Usage

```nix
# flake.nix
inputs.iterm2.url = "github:<owner>/<repo>";

# home-manager config
imports = [ inputs.iterm2.homeManagerModules.default ];
programs.iterm2 = {
  enable = true;
  prefsFolder = "${config.xdg.configHome}/iterm2";
};
```

### Options

| Option | Default | |
| --- | --- | --- |
| `programs.iterm2.enable` | `false` | Enable the module. Outside macOS, only the shell integration options take effect. |
| `programs.iterm2.package` | `pkgs.iterm2` | Installed on macOS only. Set to `null` when iTerm2 is installed another way, e.g. a Homebrew cask. |
| `programs.iterm2.enable{Bash,Fish,Zsh}Integration` | `home.shell.enableShellIntegration` | Source iTerm2's [shell integration](https://iterm2.com/documentation-shell-integration.html) script, pinned to a commit of `gnachman/iTerm2-shell-integration`. |
| `programs.iterm2.prefsFolder` | `null` | Load `com.googlecode.iterm2.plist` from this directory. iTerm2 writes back to it, so use a writable path (e.g. a git checkout), not the Nix store. macOS only. |
| `programs.iterm2.saveChanges` | `"automatically"` | When iTerm2 saves UI changes to `prefsFolder`: `onQuit`, `never` or `automatically`. |
| `programs.iterm2.dynamicProfiles` | `[ ]` | Profiles written to `~/Library/Application Support/iTerm2/DynamicProfiles/home-manager.json`. Each needs a `Name` and a unique `Guid`; see [Dynamic Profiles](https://iterm2.com/documentation-dynamic-profiles.html). macOS only. |

## Outputs

- `homeManagerModules.default`: the module.

`module.nix` uses `pkgs.iterm2` from nixpkgs and has no dependency on this flake, so it can be upstreamed to home-manager as is.

## Updating

```sh
./update.sh          # pins the shell integration scripts to the latest upstream commit, rewriting rev + hashes in module.nix
./update.sh <rev>    # or to a specific commit
```
