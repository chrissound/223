{ sources ? import ./nix/sources.nix
} :
let
  niv = import sources.nixpkgs {
    overlays = [
      (_ : _ : { niv = import sources.niv {}; })
    ] ;
    config = {};
  };
  pkgs = niv.pkgs;
  myHaskellPackages = pkgs.haskellPackages.override {
    overrides = self: super: rec {
      testing123  = import (../219) {}; # this fails
      # testing123  = import (../219) { compiler = "ghc865"; }; # this works
    };
  };
in
myHaskellPackages.callCabal2nix "HaskellNixCabalStarter" (./.) {}
