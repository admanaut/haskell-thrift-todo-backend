module Examples.Versioning.RemovedFieldNewClientOldServer where

import qualified Examples.Versioning.RemovedFieldNewClientOldServer.Client as Client
import qualified Examples.Versioning.RemovedFieldNewClientOldServer.Server as Server
import qualified Control.Concurrent                                        as Async

runExample :: IO ()
runExample = do
  print "Version mismatch 4. _Removed field, new client, old server_ "

  _ <- Async.forkIO Server.runServer
  Async.threadDelay 1000000 -- 1 second. give it some time to come online
  _ <- Async.forkIO Client.connectAndRunExample
  pure ()
