{
  description = "uniks";

  outputs = { self, mkCargoNix }: {
    datom = mkCargoNix.datom {
      cargoNixPath = self + /Cargo.nix;
      nightly = true;
    };

  };
}
