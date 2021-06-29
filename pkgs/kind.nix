{ pkgs, system }: version:
let
  name = "kind";
  sha = {
    x86_64-linux = {
      "0.9.0" = "1j0da1qqg4r34bb6i0rkywn3sh2pqqqzvdjidbc954a7rbh419im";
      "0.11.1" = "1484bxydwbpp02ab2a3sq3ns63qh9yhcvppz9qykm80cqfrq37wl";
    };
  };
  deriv = pkgs.stdenv.mkDerivation (
    import ./helpers/directBinary.nix pkgs {
      inherit name;
      url = "https://github.com/kubernetes-sigs/kind/releases/download/v${version}/kind-linux-amd64";
      sha256 = sha.${system}.${version};
    }
  );
in
import ./helpers/derivWithErr.nix {
  inherit system version name sha deriv;
}
