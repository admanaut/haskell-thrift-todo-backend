with (import <nixpkgs> {});

haskellPackages.ghcWithPackages (p: with p; [
  containers
  lens
  text
])