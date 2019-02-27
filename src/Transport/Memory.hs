module Transport.Memory where

import qualified Data.ByteString.Lazy as ByteString.Lazy
import qualified Thrift.Transport as Transport
import qualified Thrift.Transport.IOBuffer as IOBuffer


data InputTransport
  = InputTransport
      { inputBuffer :: IOBuffer.ReadBuffer
      }

instance Transport.Transport InputTransport where
    tPeek t
      = IOBuffer.peekBuf (inputBuffer t)

    tRead t n
      = IOBuffer.readBuf (inputBuffer t) n

    tWrite _ _
      = error "Not supported"

    tFlush  _
      = error "Not supported"

    tIsOpen _ = pure True
    tClose    = pure (pure ())


mkInputTransport :: IO InputTransport
mkInputTransport
  = InputTransport <$> IOBuffer.newReadBuffer

fillInput :: InputTransport -> ByteString.Lazy.ByteString -> IO ()
fillInput t body
  = IOBuffer.fillBuf (inputBuffer t) body

extractOutput :: OutputTransport -> IO ByteString.Lazy.ByteString
extractOutput t
  = IOBuffer.flushBuf (outputBuffer t)


mkOutputTransport :: IO OutputTransport
mkOutputTransport
  = OutputTransport <$> IOBuffer.newWriteBuffer



data OutputTransport
  = OutputTransport
      { outputBuffer :: IOBuffer.WriteBuffer
      }

instance Transport.Transport OutputTransport where
    tPeek _
      = error "Not supported"

    tRead _ _
      = error "Not supported"

    tWrite t bytes
      = IOBuffer.writeBuf (outputBuffer t) bytes

    -- Flushing doesn't make sense here
    tFlush  _ = pure ()

    tIsOpen _ = pure True
    tClose    = pure (pure ())


