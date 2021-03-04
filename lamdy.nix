{ kor, mkCargoNix }:
let
  crates = mkCargoNix {
    cargoNix = import ./Cargo.nix;
    nightly = true;
  };

in
{
  meikPod = Pod@{ neim, ... }:
    derivation {
      name = neim;
      builder = crates.workspace.meikPod;
      inherit Pod;
      system = hyraizyn.astra.sistym;
      __structuredAttrs = true;
    };
}
