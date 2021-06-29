pkgs: version:
pkgs.stdenv.mkDerivation {
  name = "bats";
  phases = [ "installPhase" ];
  src = builtins.fetchGit {
    url = "https://github.com/bats-core/bats-core.git";
    ref = "refs/tags/v" + version;
  };
  installPhase = ''
    mkdir -p $out/{bin,libexec/bats-core,lib/bats-core}
    cp $src/bin/* $out/bin/
    cp $src/libexec/bats-core/* $out/libexec/bats-core/
    cp $src/lib/bats-core/* $out/lib/bats-core/
  '';
}
