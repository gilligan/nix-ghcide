rec {
  ghcide-ghc864 = (import ./.) { compiler = "ghc864"; };
  ghcide-ghc865 = (import ./.) { compiler = "ghc865"; };
  ghcide-ghc844 = (import ./.) { compiler = "ghc844"; };

  ghcide-wrapper = (import ./ghcide-wrapper.nix) { inherit ghcide-ghc864 ghcide-ghc865 ghcide-ghc844; };
}
