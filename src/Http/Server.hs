{-# LANGUAGE OverloadedStrings #-}
module Http.Server where

import qualified Data.ByteString.Lazy as ByteString.Lazy
import qualified Thrift.Protocol.JSON as Protocol.JSON
import qualified Web.Scotty as Scotty

import qualified Common.Server as Common
import qualified TodoBackend as Todo
import qualified Transport.Memory as Memory


port :: Int
port = 9085

runServer :: IO ()
runServer = do
  handler <- Common.newTodoBackendHandler

  Common.sprint $ "Starting JSON protocol over HTTP on localhost:" <> (show port)

  Scotty.scotty port $ do
    Scotty.post "/thrift" $ do
      body <- Scotty.body
      result <- Scotty.liftAndCatchIO $ do
        Common.sprint body

        read <- Memory.mkInputTransport
        let jsonInput = Protocol.JSON.JSONProtocol read

        write <- Memory.mkOutputTransport
        let jsonOutput = Protocol.JSON.JSONProtocol write

        Memory.fillInput read body
        _ <- Todo.process handler (jsonInput, jsonOutput)

        Memory.extractOutput write

      Scotty.raw result
