module Main where

import qualified Binary.Main as B
import qualified JSON.Main as J

main :: IO ()
main = do
  print "Running examples..."
  B.example
  J.example
