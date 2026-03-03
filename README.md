# Chawan Nix Flake

Nix flake for `chawan` from `nixos-unstable` with automated lockfile updates.

This gives you unstable `chawan` without manually updating tarball hashes.

## Install

Add to your main flake inputs:

```nix
inputs = {
  chawan-flake.url = "github:kbwhodat/chawan-nix-flake";
};
```

Do not set `chawan-flake.inputs.nixpkgs.follows = "nixpkgs"` if you want
this flake to stay on `nixos-unstable` independently.

Use the package:

```nix
programs.chawan.package = inputs.chawan-flake.packages.${pkgs.system}.default;
```

## Supported systems

- `x86_64-linux`
- `aarch64-linux`
- `aarch64-darwin`

## CI and cache coverage

GitHub Actions currently builds and pushes binaries to Cachix for:

- `x86_64-linux`
- `aarch64-darwin`

## Updating

Run locally:

```sh
nix run .#update
```

That updates `flake.lock` for `nixpkgs` and creates a commit when changes exist.

GitHub Actions also runs daily via `.github/workflows/update.yml`.

Note: `update.yml` expects a `PAT` repository secret for push access.

## Binary cache (no local builds)

This repo is configured to push build outputs to Cachix on `main`/`master` pushes.

Set this repository secret in GitHub:

- `CACHIX_AUTH_TOKEN` (token for cache `chawan-nix-flake`)

Then consumers can use the cache:

```nix
nix.settings = {
  substituters = [
    "https://cache.nixos.org"
    "https://chawan-nix-flake.cachix.org"
  ];
  trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "chawan-nix-flake.cachix.org-1:guW77ag6Q9K4NVJ3gh5H4jsT4QlKfYAVooSFbDXAxD4="
  ];
};
```
