{ pkgs, system }: version:
let
  name = "terraform";
  sha = {
    x86_64-linux = {
      "0.11.14" = "1pgqi8m34vwsyq86cndmix7brwcy59dmyncy0xxhfsccff9496lv";
      "0.12.29" = "07asklzd12ic21h1ybashrhfzr7imq8f18cq1pf28arhqvcla8l7";
      "0.13.2" = "6c1c6440c5cb199e85926aea65773450564f501fddcd7876f453ba95b45ba746";
      "0.14.6" = "0x0hpiykp5kgy8s9g57a0jrgdrvf6jbcx1lc4wzzldg4vmga99b3";
      "0.15.4" = "0p1j9q8j09v2cirvalwyzz0yysqhkbd81h77si23p34vb44v9yfx";
      "1.0.1" = "1wyf51vlmnw21xymn93102xmizrmch9l2h3fm4sqsv33jdsnb56s";
    };
    x86_64-darwin = {
      "1.0.1" = "32c5b3123bc7a4284131dbcabd829c6e72f7cc4df7a83d6e725eb97905099317";
    };
  };
  deriv = pkgs.stdenv.mkDerivation
    (
      import ./helpers/hashicorpReleases.nix pkgs system {
        inherit name;
        sha256 = sha.${system}.${version};
        version = version;
      }
    );
in
import ./helpers/derivWithErr.nix { inherit system version name sha deriv; }
