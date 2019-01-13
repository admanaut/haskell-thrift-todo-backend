module Binary.Main where

import qualified Binary.Client as Client
import qualified Binary.Server as Server
import qualified Control.Concurrent as Async

example :: IO ()
example = do
  -- run server in new thread
  _ <- Async.forkIO Server.runServer

  Async.threadDelay 1000000 -- wait 1 second
  Client.connectAndRunExample
