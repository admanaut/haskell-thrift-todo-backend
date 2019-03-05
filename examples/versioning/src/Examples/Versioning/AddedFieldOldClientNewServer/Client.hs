{-# LANGUAGE PackageImports #-}

module Examples.Versioning.AddedFieldOldClientNewServer.Client where

import qualified "todo-backend" TodoBackend_Client as Client
import qualified "todo-backend" Todobackend_Types  as Types

import qualified Data.Text.Lazy as Tx.L
import qualified Thrift.Protocol as P
import qualified Network as Ntw
import qualified Thrift.Protocol.Binary as Proto
import qualified Thrift.Transport.Handle as H

-- |
connectAndRunExample :: IO ()
connectAndRunExample = do
  cprint "Connecting Old Client to New Server on localhost:9080 ..."
  transport <- H.hOpen ("localhost" :: Ntw.HostName, Ntw.PortNumber 9080)

  cprint "configuring Binary Protocol ..."
  let proto = Proto.BinaryProtocol transport
  let client = (proto, proto)

  runExample client

  cprint "closing connection."
  H.tClose transport


-- ---------------------------------------
-- Client example
-- --------------------------------------

-- | Run client example.
--
runExample
  :: P.Protocol p
  => (p, p)
  -> IO ()

runExample client = do
  -- Create
  todo <- Client.createTodo client (Tx.L.pack "Clean house")
  cprint todo

  print "" -- empty line

  -- Get
  gtodo <- Client.getTodo client 1
  cprint gtodo

  print "" -- empty line

  -- Update
  let utodo = gtodo { Types.todo_completed = True }
  uutodo <- Client.updateTodo client utodo
  cprint uutodo

  print "" -- empty line

  -- Delete
  Client.deleteTodo client 1

cprint :: Show a => a -> IO ()
cprint a = print $ "    Client: " <> show a
