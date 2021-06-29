{ pkgs, system }: version:
let
  name = "kind";
  sha = {
    x86_64-linux = {
      "0.9.0" = "1j0da1qqg4r34bb6i0rkywn3sh2pqqqzvdjidbc954a7rbh419im";
      "0.11.1" = "1484bxydwbpp02ab2a3sq3ns63qh9yhcvppz9qykm80cqfrq37wl";
    };
    x86_64-darwin = {
      "0.9.0" = "146y32skgl0ax8c58j81zsx66n4d6688h1skj47yb858mvzk9444";
      "0.11.1" = "1qvwz6xydlf4qkp1npzpyym9wnr6b2b7a7368h5kdsbhb9ayyas3";
    };
  };
  systemToPath = {
    x86_64-linux = "linux-amd64";
    x86_64-darwin = "darwin-amd64";
  };
  deriv = pkgs.stdenv.mkDerivation (
    import ./helpers/directBinary.nix pkgs {
      inherit name;
      url = "https://github.com/kubernetes-sigs/kind/releases/download/v${version}/kind-${systemToPath.${system}}";
      sha256 = sha.${system}.${version};
    }
  );
in
import ./helpers/derivWithErr.nix {
  inherit system version name sha deriv;
}
