module Examples.Protocols.Common.Server where

import qualified Control.Concurrent as Async
import qualified Data.Int as I
import qualified Data.Map as M
import qualified Data.Text.Lazy as LT
import qualified TodoBackend_Iface as Iface
import qualified Todobackend_Types as Types

-- ---------------------------------------
-- Server Instance
-- --------------------------------------

instance Iface.TodoBackend_Iface TodoBackendHandler where
  createTodo = createTodoHandler
  getTodo    = getTodoHandler
  updateTodo = updateTodoHandler
  deleteTodo = deleteTodoHandler

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
