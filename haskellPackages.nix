with import <nixpkgs> {};

let wrapPackages = callPackage <bazel_haskell_wrapper> { }; in
{ haskellPackages = wrapPackages haskell.packages.ghc843; }
