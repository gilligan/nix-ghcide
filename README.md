## ghcide for nix 

Nix expressions for [ghcide](https://github.com/digital-asset/ghcide). Provides binaries for

- ghc844
- ghc864
- ghc865

Also provided is `ghcide-wrapper` which picks one of the versions above based on the
output of `ghc --version`.

### ghcide-wrapper

Instead of specifying one of the ghc-specific versions just specify `ghcide-wrapper --lsp` as the
lsp server command in your editor configuration.

### Installation

```
$ nix-env -iA ghcide-wrapper -f https://github.com/gilligan/nix-ghcide/tarball/master
```

### Cachix

```
$ cachix use ghcide
```

### But.. Why?

I am aware that there is [ghcide-nix](https://github.com/hercules-ci/ghcide-nix) already
and `ghcide` should land in nixpkgs/master sometime soon but I had already started so i might
as well stick to it ;) This repo builds on Nixpkgs' `haskellPackages` rather than relying on [`haskell.nix`](https://input-output-hk.github.io/haskell.nix/). It
makes liberal use of jailbreaking to compile ghcide with what's in `haskellPackages`. 
