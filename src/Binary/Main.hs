module Binary.Main where

import qualified Binary.Client as Client
-- import qualified Binary.Server as Server

main :: IO ()
main = do
  -- Server.start
  Client.client
