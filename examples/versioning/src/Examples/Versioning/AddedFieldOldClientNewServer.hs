module Examples.Versioning.AddedFieldOldClientNewServer where

import qualified Examples.Versioning.AddedFieldOldClientNewServer.Client as Client
import qualified Examples.Versioning.AddedFieldOldClientNewServer.Server as Server
import qualified Control.Concurrent                                      as Async

runExample :: IO ()
runExample = do
  print "Version mismatch 1. _Added field, old client, new server_ "

  _ <- Async.forkIO Server.runServer
  Async.threadDelay 1000000 -- 1 second. give it some time to come online
  _ <- Async.forkIO Client.connectAndRunExample
  pure ()
