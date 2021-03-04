{
  description = "uniks";

  outputs = { self }: {
    SobUyrld = {
      modz = [ "uyrld" ];
      lamdy = import ./lamdy.nix;
    };
  };
}
