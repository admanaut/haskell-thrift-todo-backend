module Main where

import qualified Examples.Versioning.AddedFieldOldClientNewServer as AddOldNew
import qualified Examples.Versioning.RemovedFieldNewClientOldServer as RemoveNewOld
import qualified Control.Concurrent as Async

main :: IO ()
main = do
  print "Running examples..."
  AddOldNew.runExample

  Async.threadDelay 1000000 -- 1 second. give it some time to come online

  RemoveNewOld.runExample
