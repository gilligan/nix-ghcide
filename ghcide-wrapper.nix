{ pkgs ? import ((import ./nix/sources.nix).nixpkgs) {}
, ghcide-ghc844
, ghcide-ghc864
, ghcide-ghc865
}:

pkgs.writeShellScriptBin "ghcide-wrapper" ''
  VER=$(ghc --version | cut -f 8 -d " ")

  case $VER in
    "8.4.4" )
      ${ghcide-ghc844}/bin/ghcide $*
        ;;
    "8.6.4" )
      ${ghcide-ghc864}/bin/ghcide $*
        ;;
    "8.6.5" )
      ${ghcide-ghc865}/bin/ghcide $*
        ;;
    *)
      echo "Oops, unnkown ghc version!"
      exit 1
      ;;
  esac
''
