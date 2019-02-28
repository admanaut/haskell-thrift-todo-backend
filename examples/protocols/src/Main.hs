module Main where

import qualified Examples.Protocols.Binary.Main as B
import qualified Examples.Protocols.JSON.Main as J

main :: IO ()
main = do
  print "Running examples..."
  B.example
  J.example
