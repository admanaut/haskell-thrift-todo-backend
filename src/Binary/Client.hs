module Binary.Client where

import qualified Data.Text.Lazy as Tx.L
import qualified Network as Ntw
import qualified Thrift.Protocol.Binary as Proto
import qualified Thrift.Transport.Handle as H
import qualified TodoBackend_Client as Client
import qualified Todobackend_Types as Types

connectAndRunExample :: IO ()
connectAndRunExample = do
  cprint "Opening a stream socket and connecting to localhost:9090 ..."
  transport <- H.hOpen ("localhost" :: Ntw.HostName, Ntw.PortNumber 9090)

  cprint "configuring Binary Protocol ..."
  let proto = Proto.BinaryProtocol transport
  let client = (proto, proto)

  runExample client

  cprint "closing connection."
  H.tClose transport

runExample
  :: H.Transport t
  => (Proto.BinaryProtocol t, Proto.BinaryProtocol t)
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
