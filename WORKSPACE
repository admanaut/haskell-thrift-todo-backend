workspace(name = "todobackend")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# {{ NIXPKGS ###################################################################

rules_nixpkgs_version = "c232b296e795ad688854ff3d3d2de6e7ad45f0b4"
rules_nixpkgs_sha256 = "5883ea01f3075354ab622cfe82542da01fe2b57a48f4c3f7610b4d14a3fced11"

http_archive(
    name = "io_tweag_rules_nixpkgs",
    sha256 = rules_nixpkgs_sha256,
    strip_prefix = "rules_nixpkgs-%s" % rules_nixpkgs_version,
    urls = ["https://github.com/tweag/rules_nixpkgs/archive/%s.tar.gz" % rules_nixpkgs_version],
)

load(
    "@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl",
    "nixpkgs_package",
    "nixpkgs_git_repository",
#    "nixpkgs_cc_configure",
)

nixpkgs_git_repository(
    name = "nixpkgs",
    remote = "https://github.com/NixOS/nixpkgs",
    revision = "18.09",
    sha256 = "6451af4083485e13daa427f745cbf859bc23cb8b70454c017887c006a13bd65e",
)

# nixpkgs_cc_configure(
#     repository = "@nixpkgs",
# )

# }} NIXPKGS ###################################################################




# {{ HASKELL ###################################################################

http_archive(
  name = "io_tweag_rules_haskell",
  strip_prefix = "rules_haskell-0.8",
  urls = ["https://github.com/tweag/rules_haskell/archive/v0.8.tar.gz"]
)

load("@io_tweag_rules_haskell//haskell:repositories.bzl", "haskell_repositories")
haskell_repositories()

nixpkgs_package(
  name = "ghc",
  attribute_path = "haskell.compiler.ghc843",
  repository = "@nixpkgs",
)

register_toolchains("//:ghc")

### Hackage

load("@io_tweag_rules_haskell//haskell:nixpkgs.bzl", "haskell_nixpkgs_packageset")

haskell_nixpkgs_packageset(
  name = "hackage-packages",
  repositories = {"nixpkgs": "@nixpkgs"},
  nix_file = "//:haskellPackages.nix",
  base_attribute_path = "haskellPackages",
)

load("@hackage-packages//:packages.bzl", "import_packages")

import_packages(
    name = "hackage",
)

# }} Haskell ###################################################################
