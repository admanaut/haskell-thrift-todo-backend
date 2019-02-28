module Examples.Protocols.JSON.Server where

import qualified Examples.Protocols.Common.Server as Common
import qualified Network as Ntw
import qualified Thrift.Protocol.JSON as Proto
import qualified Thrift.Server as Th
import qualified TodoBackend as Todo


-- ---------------------------------------
-- Server Main
-- --------------------------------------

-- | Run JSON protocol socket server.
--
runServer :: IO ()
runServer = do
  handler <- Common.newTodoBackendHandler
  Common.sprint "Starting binary protocol socket server on localhost:9080"

  _ <- Th.runThreadedServer jsonAccept handler Todo.process (Ntw.PortNumber 9080)

  Common.sprint "closing down server"

  where
    jsonAccept s = do
      (h, _, _) <- Ntw.accept s
      pure (Proto.JSONProtocol h, Proto.JSONProtocol h)
