{ system, version, name, sha, deriv }:
if !builtins.hasAttr "${system}" sha
then abort "${name} is not yet supported for your platform (${system})"
else if !builtins.hasAttr "${version}" sha.${system}
then abort "${name}:${version} is not yet supported for your platform (${system})"
else deriv
