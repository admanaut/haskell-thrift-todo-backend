module Main where

import qualified Data.Text.Lazy          as Tx.L
import qualified Network                 as Ntw
-- import qualified Thrift                  as Thr
import qualified Thrift.Protocol.Binary  as Proto
-- import qualified Thrift.Server           as Srv
-- import qualified Thrift.Transport        as Tr
import qualified Thrift.Transport.Handle as H

-- import           TodoBackend
import qualified TodoBackend_Client      as Client
-- import           Todobackend_Types

-- | An example of how the client library can be used.
--
--
main = do
  transport <- H.hOpen ("localhost" :: Ntw.HostName, Ntw.PortNumber 9090) -- server should listen at this port
  let binProto = Proto.BinaryProtocol transport
  let client = (binProto, binProto)

  todo <- Client.createTodo client (Tx.L.pack "Clean house")
  print todo

  -- Close
  H.tClose transport
