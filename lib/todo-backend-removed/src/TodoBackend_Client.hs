{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -fno-warn-missing-fields #-}
{-# OPTIONS_GHC -fno-warn-missing-signatures #-}
{-# OPTIONS_GHC -fno-warn-name-shadowing #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

-----------------------------------------------------------------
-- Autogenerated by Thrift Compiler (0.11.0)                      --
--                                                             --
-- DO NOT EDIT UNLESS YOU ARE SURE YOU KNOW WHAT YOU ARE DOING --
-----------------------------------------------------------------

module TodoBackend_Client(createTodo,getTodo,updateTodo,deleteTodo) where
import qualified Data.IORef as R
import Prelude (($), (.), (>>=), (==), (++))
import qualified Prelude as P
import qualified Control.Exception as X
import qualified Control.Monad as M ( liftM, ap, when )
import Data.Functor ( (<$>) )
import qualified Data.ByteString.Lazy as LBS
import qualified Data.Hashable as H
import qualified Data.Int as I
import qualified Data.Maybe as M (catMaybes)
import qualified Data.Text.Lazy.Encoding as E ( decodeUtf8, encodeUtf8 )
import qualified Data.Text.Lazy as LT
import qualified GHC.Generics as G (Generic)
import qualified Data.Typeable as TY ( Typeable )
import qualified Data.HashMap.Strict as Map
import qualified Data.HashSet as Set
import qualified Data.Vector as Vector
import qualified Test.QuickCheck.Arbitrary as QC ( Arbitrary(..) )
import qualified Test.QuickCheck as QC ( elements )

import qualified Thrift as T
import qualified Thrift.Types as T
import qualified Thrift.Arbitraries as T


import Todobackendremoved_Types
import TodoBackend
seqid = R.newIORef 0
createTodo (ip,op) arg_title = do
  send_createTodo op arg_title
  recv_createTodo ip
send_createTodo op arg_title = do
  seq <- seqid
  seqn <- R.readIORef seq
  T.writeMessage op ("createTodo", T.M_CALL, seqn) $
    write_CreateTodo_args op (CreateTodo_args{createTodo_args_title=arg_title})
recv_createTodo ip = do
  T.readMessage ip $ \(fname, mtype, rseqid) -> do
    M.when (mtype == T.M_EXCEPTION) $ do { exn <- T.readAppExn ip ; X.throw exn }
    res <- read_CreateTodo_result ip
    P.return $ createTodo_result_success res
getTodo (ip,op) arg_id = do
  send_getTodo op arg_id
  recv_getTodo ip
send_getTodo op arg_id = do
  seq <- seqid
  seqn <- R.readIORef seq
  T.writeMessage op ("getTodo", T.M_CALL, seqn) $
    write_GetTodo_args op (GetTodo_args{getTodo_args_id=arg_id})
recv_getTodo ip = do
  T.readMessage ip $ \(fname, mtype, rseqid) -> do
    M.when (mtype == T.M_EXCEPTION) $ do { exn <- T.readAppExn ip ; X.throw exn }
    res <- read_GetTodo_result ip
    P.return $ getTodo_result_success res
updateTodo (ip,op) arg_todo = do
  send_updateTodo op arg_todo
  recv_updateTodo ip
send_updateTodo op arg_todo = do
  seq <- seqid
  seqn <- R.readIORef seq
  T.writeMessage op ("updateTodo", T.M_CALL, seqn) $
    write_UpdateTodo_args op (UpdateTodo_args{updateTodo_args_todo=arg_todo})
recv_updateTodo ip = do
  T.readMessage ip $ \(fname, mtype, rseqid) -> do
    M.when (mtype == T.M_EXCEPTION) $ do { exn <- T.readAppExn ip ; X.throw exn }
    res <- read_UpdateTodo_result ip
    P.return $ updateTodo_result_success res
deleteTodo (ip,op) arg_todo = do
  send_deleteTodo op arg_todo
  recv_deleteTodo ip
send_deleteTodo op arg_todo = do
  seq <- seqid
  seqn <- R.readIORef seq
  T.writeMessage op ("deleteTodo", T.M_CALL, seqn) $
    write_DeleteTodo_args op (DeleteTodo_args{deleteTodo_args_todo=arg_todo})
recv_deleteTodo ip = do
  T.readMessage ip $ \(fname, mtype, rseqid) -> do
    M.when (mtype == T.M_EXCEPTION) $ do { exn <- T.readAppExn ip ; X.throw exn }
    res <- read_DeleteTodo_result ip
    P.return ()
