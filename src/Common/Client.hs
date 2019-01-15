module Common.Client where

import qualified Data.Text.Lazy as Tx.L
import qualified Thrift.Protocol as P
import qualified TodoBackend_Client as Client
import qualified Todobackend_Types as Types

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
