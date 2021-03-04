{ kor, mkCargoNix }:
let
  klomziKreits = (
    mkCargoNix {
      cargoNix = import ./Cargo.nix;
      nightly = true;
    }
  ).workspaceMembers;

in
{
  meikPod = Pod@{ neim, ... }:
    derivation {
      name = neim;
      builder = "${klomziKreits.meikPod.build}/bin/meikPod";
      inherit Pod;
      system = hyraizyn.astra.sistym;
      __structuredAttrs = true;
    };
}
