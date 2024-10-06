module Gio.PollableOutputStreamInterface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The interface for pollable output streams.
 * The default implementation of @can_poll always returns %TRUE.
 * The default implementation of @write_nonblocking calls
 * [Gio.PollableOutputStream.isWritable], and then calls
 * [Gio.OutputStream.write] if it returns %TRUE. This means you only
 * need to override it if it is possible that your @is_writable
 * implementation may return %TRUE when the stream is not actually
 * writable.
 * The default implementation of @writev_nonblocking calls
 * [Gio.PollableOutputStream.writeNonblocking] for each vector, and converts
 * its return value and error $(LPAREN)if set$(RPAREN) to a #GPollableReturn. You should
 * override this where possible to avoid having to allocate a #GError to return
 * %G_IO_ERROR_WOULD_BLOCK.
 */
class PollableOutputStreamInterface
{
  GPollableOutputStreamInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.PollableOutputStreamInterface");

    cInstance = *cast(GPollableOutputStreamInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GPollableOutputStreamInterface*)cPtr).gIface);
  }

  alias CanPollFuncType = extern(C) bool function(GPollableOutputStream* stream);

  @property CanPollFuncType canPoll()
  {
    return (cast(GPollableOutputStreamInterface*)cPtr).canPoll;
  }

  alias IsWritableFuncType = extern(C) bool function(GPollableOutputStream* stream);

  @property IsWritableFuncType isWritable()
  {
    return (cast(GPollableOutputStreamInterface*)cPtr).isWritable;
  }

  alias CreateSourceFuncType = extern(C) GSource* function(GPollableOutputStream* stream, GCancellable* cancellable);

  @property CreateSourceFuncType createSource()
  {
    return (cast(GPollableOutputStreamInterface*)cPtr).createSource;
  }

  alias WriteNonblockingFuncType = extern(C) ptrdiff_t function(GPollableOutputStream* stream, void* buffer, size_t count, GError** _err);

  @property WriteNonblockingFuncType writeNonblocking()
  {
    return (cast(GPollableOutputStreamInterface*)cPtr).writeNonblocking;
  }

  alias WritevNonblockingFuncType = extern(C) GPollableReturn function(GPollableOutputStream* stream, const(GOutputVector)* vectors, size_t nVectors, size_t* bytesWritten, GError** _err);

  @property WritevNonblockingFuncType writevNonblocking()
  {
    return (cast(GPollableOutputStreamInterface*)cPtr).writevNonblocking;
  }
}
