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

module Todobackendadded_Types where
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


type Title = LT.Text

type Id = I.Int32

type Order = I.Int32

type Completed = P.Bool

type Related = Vector.Vector I.Int32

data Todo = Todo  { todo_title :: LT.Text
  , todo_id :: I.Int32
  , todo_completed :: P.Bool
  , todo_order :: I.Int32
  , todo_related :: (Vector.Vector I.Int32)
  } deriving (P.Show,P.Eq,G.Generic,TY.Typeable)
instance H.Hashable Todo where
  hashWithSalt salt record = salt   `H.hashWithSalt` todo_title record   `H.hashWithSalt` todo_id record   `H.hashWithSalt` todo_completed record   `H.hashWithSalt` todo_order record   `H.hashWithSalt` todo_related record  
instance QC.Arbitrary Todo where 
  arbitrary = M.liftM Todo (QC.arbitrary)
          `M.ap`(QC.arbitrary)
          `M.ap`(QC.arbitrary)
          `M.ap`(QC.arbitrary)
          `M.ap`(QC.arbitrary)
  shrink obj | obj == default_Todo = []
             | P.otherwise = M.catMaybes
    [ if obj == default_Todo{todo_title = todo_title obj} then P.Nothing else P.Just $ default_Todo{todo_title = todo_title obj}
    , if obj == default_Todo{todo_id = todo_id obj} then P.Nothing else P.Just $ default_Todo{todo_id = todo_id obj}
    , if obj == default_Todo{todo_completed = todo_completed obj} then P.Nothing else P.Just $ default_Todo{todo_completed = todo_completed obj}
    , if obj == default_Todo{todo_order = todo_order obj} then P.Nothing else P.Just $ default_Todo{todo_order = todo_order obj}
    , if obj == default_Todo{todo_related = todo_related obj} then P.Nothing else P.Just $ default_Todo{todo_related = todo_related obj}
    ]
from_Todo :: Todo -> T.ThriftVal
from_Todo record = T.TStruct $ Map.fromList $ M.catMaybes
  [ (\_v2 -> P.Just (1, ("title",T.TString $ E.encodeUtf8 _v2))) $ todo_title record
  , (\_v2 -> P.Just (2, ("id",T.TI32 _v2))) $ todo_id record
  , (\_v2 -> P.Just (3, ("completed",T.TBool _v2))) $ todo_completed record
  , (\_v2 -> P.Just (4, ("order",T.TI32 _v2))) $ todo_order record
  , (\_v2 -> P.Just (5, ("related",T.TList T.T_I32 $ P.map (\_v4 -> T.TI32 _v4) $ Vector.toList _v2))) $ todo_related record
  ]
write_Todo :: T.Protocol p => p -> Todo -> P.IO ()
write_Todo oprot record = T.writeVal oprot $ from_Todo record
encode_Todo :: T.StatelessProtocol p => p -> Todo -> LBS.ByteString
encode_Todo oprot record = T.serializeVal oprot $ from_Todo record
to_Todo :: T.ThriftVal -> Todo
to_Todo (T.TStruct fields) = Todo{
  todo_title = P.maybe (P.error "Missing required field: title") (\(_,_val6) -> (case _val6 of {T.TString _val7 -> E.decodeUtf8 _val7; _ -> P.error "wrong type"})) (Map.lookup (1) fields),
  todo_id = P.maybe (P.error "Missing required field: id") (\(_,_val6) -> (case _val6 of {T.TI32 _val8 -> _val8; _ -> P.error "wrong type"})) (Map.lookup (2) fields),
  todo_completed = P.maybe (P.error "Missing required field: completed") (\(_,_val6) -> (case _val6 of {T.TBool _val9 -> _val9; _ -> P.error "wrong type"})) (Map.lookup (3) fields),
  todo_order = P.maybe (P.error "Missing required field: order") (\(_,_val6) -> (case _val6 of {T.TI32 _val10 -> _val10; _ -> P.error "wrong type"})) (Map.lookup (4) fields),
  todo_related = P.maybe (todo_related default_Todo) (\(_,_val6) -> (case _val6 of {T.TList _ _val11 -> (Vector.fromList $ P.map (\_v12 -> (case _v12 of {T.TI32 _val13 -> _val13; _ -> P.error "wrong type"})) _val11); _ -> P.error "wrong type"})) (Map.lookup (5) fields)
  }
to_Todo _ = P.error "not a struct"
read_Todo :: T.Protocol p => p -> P.IO Todo
read_Todo iprot = to_Todo <$> T.readVal iprot (T.T_STRUCT typemap_Todo)
decode_Todo :: T.StatelessProtocol p => p -> LBS.ByteString -> Todo
decode_Todo iprot bs = to_Todo $ T.deserializeVal iprot (T.T_STRUCT typemap_Todo) bs
typemap_Todo :: T.TypeMap
typemap_Todo = Map.fromList [(1,("title",T.T_STRING)),(2,("id",T.T_I32)),(3,("completed",T.T_BOOL)),(4,("order",T.T_I32)),(5,("related",(T.T_LIST T.T_I32)))]
default_Todo :: Todo
default_Todo = Todo{
  todo_title = "",
  todo_id = 0,
  todo_completed = P.False,
  todo_order = 0,
  todo_related = (Vector.fromList [(10)])}
