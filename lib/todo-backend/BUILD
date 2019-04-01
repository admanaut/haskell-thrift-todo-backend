package(default_visibility = ["//visibility:public"])

load(
  "@io_tweag_rules_haskell//haskell:haskell.bzl",
  "haskell_library",
  "haskell_import",
)

haskell_import(name = "base")
haskell_import(name = "bytestring")
haskell_import(name = "text")
haskell_import(name = "hashable")
haskell_import(name = "containers")
haskell_import(name = "vector")
haskell_import(name = "thrift")
haskell_import(name = "QuickCheck")
haskell_import(name = "unordered-containers")

haskell_library(
  name = "todo-backend",
  src_strip_prefix = "src",
  srcs = glob(['src/**/*.hs']),
  deps = [
      ":base",
      ":bytestring",
      "@hackage//:text",
      "@hackage//:hashable",
      "@hackage//:containers",
#      "@hackage//:vector",
      "@hackage//:thrift",
      "@hackage//:QuickCheck",
      "@hackage//:unordered-containers",
  ],
)
