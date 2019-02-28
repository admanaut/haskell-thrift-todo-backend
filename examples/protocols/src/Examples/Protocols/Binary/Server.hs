module Examples.Protocols.Binary.Server where

import qualified Examples.Protocols.Common.Server as Common
import qualified Thrift.Server as Th
import qualified TodoBackend as Todo

-- ---------------------------------------
-- Server Main
-- --------------------------------------

-- | Run binary protocol socket server.
--
runServer :: IO ()
runServer = do
  handler <- Common.newTodoBackendHandler
  Common.sprint "Starting binary protocol socket server on localhost:9090"
  _ <- Th.runBasicServer handler Todo.process 9090
  print "closing down server"
