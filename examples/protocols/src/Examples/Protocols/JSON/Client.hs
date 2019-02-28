module Examples.Protocols.JSON.Client where

import qualified Examples.Protocols.Common.Client as Ex
import qualified Network as Ntw
import qualified Thrift.Protocol.JSON as Proto
import qualified Thrift.Transport.Handle as H

connectAndRunExample :: IO ()
connectAndRunExample = do
  Ex.cprint "Opening a stream socket and connecting to localhost:9080 ..."
  transport <- H.hOpen ("localhost" :: Ntw.HostName, Ntw.PortNumber 9080)

  Ex.cprint "configuring JSON Protocol ..."
  let proto = Proto.JSONProtocol transport
  let client = (proto, proto)

  Ex.runExample client

  Ex.cprint "closing connection."
  H.tClose transport
