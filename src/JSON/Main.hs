module JSON.Main where

import qualified JSON.Client as Client
import qualified JSON.Server as Server
import qualified Control.Concurrent as Async

example :: IO ()
example = do
  _ <- Async.forkIO Server.runServer
  _ <- Async.forkIO Client.connectAndRunExample
  pure ()
