{ pkgs, system }: version:
let
  name = "operator-sdk";
  sha = {
    x86_64-linux = {
      "1.3.0" = "17cnj1q47rz1g6l9g3n54rgycz5cz9jr9zmd3w31kxj8wg5rdlcr";
    };
    x86_64-darwin = {
      "1.3.0" = "1ykm295h5pky88k6ix62k7wf9nz2phbgw287k7zd5j74j5kfmlwr";
    };
  };
  systemToPath = {
    x86_64-linux = "linux";
    x86_64-darwin = "darwin";
  };
  deriv = pkgs.stdenv.mkDerivation (
    import ./helpers/directBinary.nix pkgs {
      inherit name;
      url = "https://github.com/operator-framework/operator-sdk/releases/download/v${version}/operator-sdk_${systemToPath.${system}}_amd64";
      sha256 = sha.${system}.${version};
    }
  );
in
import ./helpers/derivWithErr.nix {
  inherit system version name sha deriv;
}
