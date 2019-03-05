{-# LANGUAGE PackageImports #-}

module Examples.Versioning.AddedFieldOldClientNewServer.Server where

import qualified "todo-backend-added" Todobackendadded_Types as Types
import qualified "todo-backend-added" TodoBackend_Iface      as Iface
import qualified "todo-backend-added" TodoBackend            as Todo

import qualified Control.Concurrent as Async
import qualified Data.Int           as I
import qualified Data.Map           as M
import qualified Data.Text.Lazy     as LT

import qualified Thrift.Server as Th

-- ---------------------------------------
-- Server Main
-- --------------------------------------

-- | Run binary protocol socket server.
--
runServer :: IO ()
runServer = do
  handler <- newTodoBackendHandler
  sprint "Starting New Server on localhost:9080"
  _ <- Th.runBasicServer handler Todo.process 9080
  print "closing down server"



-- ---------------------------------------
-- Server Instance
-- --------------------------------------

instance Iface.TodoBackend_Iface TodoBackendHandler where
  createTodo = createTodoHandler
  getTodo    = getTodoHandler
  updateTodo = updateTodoHandler
  deleteTodo = deleteTodoHandler

  -- added method
  getRelated = getRelatedHandler

-- ---------------------------------------
-- Handler and state
-- --------------------------------------

newtype TodoBackendHandler = TodoBackendHandler { getState :: Async.MVar ServerState }

type ServerState = M.Map Int Types.Todo

-- | Create handler and initialise state
--
newTodoBackendHandler :: IO TodoBackendHandler
newTodoBackendHandler = do
  state <- Async.newMVar mempty
  pure $ TodoBackendHandler state

getServerState :: TodoBackendHandler -> IO ServerState
getServerState = Async.readMVar . getState

updateServerState_
  :: TodoBackendHandler
  -> ServerState
  -> IO ()
updateServerState_ h st' = do
  let mvar = getState h
  Async.modifyMVar_ mvar (const $ pure st')

-- ---------------------------------------
--           RPC handlers
-- --------------------------------------

-- | Creates a Todo with the given title
-- and adds it to the server state.
createTodoHandler
  :: TodoBackendHandler
  -> LT.Text
  -> IO Types.Todo
createTodoHandler h title = do
  sprint $ "Creating TODO '"<> show title <> "'"

  state <- getServerState h
  let (td, state') = addTodo state

  updateServerState_ h state'
  pure td

  where
    addTodo st =
      let (i, td) =
            if M.null st
            then (1, newTodo 1 1)
            else
              let i' = M.size st + 1
              in (i', newTodo i i)

      in (td, M.insert i td st)

    newTodo :: Int -> Int -> Types.Todo
    newTodo i o =
      Types.Todo
        { Types.todo_title     = title
        , Types.todo_id        = fromIntegral i
        , Types.todo_completed = False
        , Types.todo_order     = fromIntegral o

        -- new field
        , Types.todo_related   = mempty
        }

-- |
--
getTodoHandler
  :: TodoBackendHandler
  -> I.Int32
  -> IO Types.Todo
getTodoHandler h i = do
  sprint $ "Getting TODO with id '"<> show i <> "'"
  lookupTodo h i

lookupTodo
  :: TodoBackendHandler
  -> I.Int32
  -> IO Types.Todo
lookupTodo h i = do
  state <- getServerState h
  maybe
    (fail "Todo not found")
    pure
    $ M.lookup (fromIntegral i) state

-- |
--
updateTodoHandler
  :: TodoBackendHandler
  -> Types.Todo
  -> IO Types.Todo
updateTodoHandler h td = do
  let i = Types.todo_id td

  sprint $ "Updating Todo " <> show td

  _ <- lookupTodo h i
  state <- getServerState h
  let state' = M.insert (fromIntegral i) td state
  updateServerState_ h state'

  pure td

deleteTodoHandler
  :: TodoBackendHandler
  -> I.Int32
  -> IO ()
deleteTodoHandler h i = do
  sprint $ "Deleting Todo with id " <> show i

  _ <- lookupTodo h i
  state <- getServerState h
  let state' = M.delete (fromIntegral i) state
  updateServerState_ h state'

sprint :: Show a => a -> IO ()
sprint a = print $ "    Server: " <> show a


-- | @new@
getRelatedHandler
  :: TodoBackendHandler
  -> Types.Id
  -> IO Types.Related

getRelatedHandler _ _ = pure mempty
