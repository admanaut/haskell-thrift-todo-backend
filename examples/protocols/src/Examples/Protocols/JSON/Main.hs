module Examples.Protocols.JSON.Main where

import qualified Examples.Protocols.JSON.Client as Client
import qualified Examples.Protocols.JSON.Server as Server
import qualified Control.Concurrent as Async

example :: IO ()
example = do
  _ <- Async.forkIO Server.runServer
  Async.threadDelay 1000000 -- 1 second. give it some time to come online
  _ <- Async.forkIO Client.connectAndRunExample
  pure ()
