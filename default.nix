{ pkgs ? import ((import ./nix/sources.nix).nixpkgs) {}
, bios ? (import ./nix/sources.nix).hie-bios
, core ? (import ./nix/sources.nix).hie-core
, rope ? (import ./nix/sources.nix).rope-utf16-splay
, haskell-lsp ? (import ./nix/sources.nix).haskell-lsp
, compiler ? "ghc864"
}:

let
  callCabal2nix = pkgs.haskell.packages.${compiler}.callCabal2nix;
  doJailbreak = pkgs.haskell.lib.doJailbreak;
  dontCheck = pkgs.haskell.lib.dontCheck;
in
  rec {
    hie-bios = doJailbreak (callCabal2nix "hie-bios" "${bios}" {});

    rope-utf16-splay = callCabal2nix "rope-utf16-splay" "${rope}" {};

    lsp-types = doJailbreak (callCabal2nix "haskell-lsp" "${haskell-lsp}/haskell-lsp-types" {});

    lsp = doJailbreak (callCabal2nix "haskell-lsp" "${haskell-lsp}" { haskell-lsp-types = lsp-types; rope-utf16-splay = rope-utf16-splay;});

    hie-core = dontCheck (doJailbreak (callCabal2nix "hie-core" "${core}/compiler/hie-core" { 
      inherit hie-bios; 
      haskell-lsp = lsp; 
      haskell-lsp-types = lsp-types;
    }));
  }
