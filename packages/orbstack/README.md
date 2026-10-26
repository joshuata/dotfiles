# OrbStack for Nix

A Nix package for [OrbStack](https://orbstack.dev/) that usually runs ahead of nixpkgs, plus a home-manager module that installs it and links its bundled Docker CLI plugins (`docker compose`, `docker buildx`).

## Usage

```nix
# flake.nix
inputs.orbstack.url = "github:<owner>/<repo>";

# home-manager config
imports = [ inputs.orbstack.homeManagerModules.default ];
programs.orbstack.enable = true;
```

OrbStack is unfree; allow it with `nixpkgs.config.allowUnfree = true` or `allowUnfreePredicate`.

### Options

| Option | Default | |
| --- | --- | --- |
| `programs.orbstack.enable` | `false` | Install OrbStack. |
| `programs.orbstack.package` | this flake's build | Any OrbStack package, e.g. `pkgs.orbstack` from nixpkgs. |
| `programs.orbstack.dockerConfigDir` | `~/.docker` | Where the CLI plugins are linked. `DOCKER_CONFIG` is exported when you change it, e.g. to `"${config.xdg.configHome}/docker"`. |

## Outputs

- `packages.<darwin-system>.orbstack` (also `default`): `nix run`/`nix build` the app directly.
- `overlays.default`: replaces `pkgs.orbstack` with this build.
- `homeManagerModules.default`: the module, with `package` defaulting to this flake's build.

`module.nix` alone uses `pkgs.orbstack` and has no dependency on this flake, so it can be upstreamed to home-manager as is.

## Updating

```sh
./update.sh   # fetches the latest release and rewrites version + hashes in package.nix
```
