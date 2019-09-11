{ pkgs ? (import ./nix/sources.nix).nixpkgs 
, bios ? (import ./nix/sources.nix).hie-bios
, ghcide ? (import ./nix/sources.nix).ghcide
, rope ? (import ./nix/sources.nix).rope-utf16-splay
, haskell-lsp ? (import ./nix/sources.nix).haskell-lsp
, compiler ? "ghc864"
}:

let
  overlay = self: pkgs: {
    hsPkgs = pkgs.haskell.packages.${compiler}.override {
      overrides = new: old: {
        Diff = if compiler == "ghc844" then pkgs.haskell.lib.dontCheck old.Diff else old.Diff;
        rope-utf16-splay = old.callCabal2nix "rope-utf16-splay" "${rope}" {};
        hie-bios = pkgs.haskell.lib.doJailbreak (old.callCabal2nix "hie-bios" "${bios}" {});
        haskell-lsp-types = pkgs.haskell.lib.doJailbreak (old.callCabal2nix "haskell-lsp" "${haskell-lsp}/haskell-lsp-types" {});
        haskell-lsp = pkgs.haskell.lib.doJailbreak (old.callCabal2nix "haskell-lsp" "${haskell-lsp}" {});
        ghcide = pkgs.haskell.lib.dontCheck (pkgs.haskell.lib.doJailbreak (old.callCabal2nix "ghcide" "${ghcide}" {}));
      };
    };
  };
in
  let 
    nixpkgs = (import pkgs {config = {}; overlays = [overlay]; });
  in
    nixpkgs.hsPkgs.ghcide
    
