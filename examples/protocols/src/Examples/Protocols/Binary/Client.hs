module Examples.Protocols.Binary.Client where

import qualified Examples.Protocols.Common.Client as Ex
import qualified Network as Ntw
import qualified Thrift.Protocol.Binary as Proto
import qualified Thrift.Transport.Handle as H

-- | Create a stream socket and aconfigure it to
-- use binary protocol, and run example.
connectAndRunExample :: IO ()
connectAndRunExample = do
  Ex.cprint "Opening a stream socket and connecting to localhost:9090 ..."
  transport <- H.hOpen ("localhost" :: Ntw.HostName, Ntw.PortNumber 9090)

  Ex.cprint "configuring Binary Protocol ..."
  let proto = Proto.BinaryProtocol transport
  let client = (proto, proto)

  Ex.runExample client

  Ex.cprint "closing connection."
  H.tClose transport
