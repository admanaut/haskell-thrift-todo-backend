module Binary.Client where

import qualified Data.Text.Lazy          as Tx.L
import qualified Network                 as Ntw
import qualified Thrift.Protocol.Binary  as Proto
import qualified Thrift.Transport.Handle as H

import qualified TodoBackend_Client      as Client

client = do
  print "Connecting to localhost:9090"

  transport <- H.hOpen ("localhost" :: Ntw.HostName, Ntw.PortNumber 9090)

  let proto = Proto.BinaryProtocol transport
  let client = (proto, proto)

  todo <- Client.createTodo client (Tx.L.pack "Clean house")
  print todo

  -- Close
  H.tClose transport
