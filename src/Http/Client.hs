module Http.Client where

import qualified Network.URI
import qualified Thrift.Protocol.JSON as Protocol.JSON
import qualified Thrift.Transport.HttpClient as HttpClient

import qualified Common.Client as Ex
import qualified Http.Server as Server

connectAndRunExample :: IO ()
connectAndRunExample = do
  let Just uri
        = Network.URI.parseURI
        $ "http://localhost:"
            <> show Server.port
            <> "/thrift"

  transport <- HttpClient.openHttpClient uri

  let proto = Protocol.JSON.JSONProtocol transport
  let client = (proto, proto)

  Ex.runExample client

  Ex.cprint "closing connection."
