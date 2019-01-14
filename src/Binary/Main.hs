module Binary.Main where

import qualified Binary.Client as Client
import qualified Binary.Server as Server
import qualified Control.Concurrent as Async

example :: IO ()
example = do
  _ <- Async.forkIO Server.runServer
  _ <- Async.forkIO Client.connectAndRunExample
  pure ()
