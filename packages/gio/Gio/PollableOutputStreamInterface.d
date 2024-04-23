module Gio.PollableOutputStreamInterface;

import GLib.Source;
import GLib.Types;
import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.Cancellable;
import Gio.PollableOutputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The interface for pollable output streams.
 *
 * The default implementation of @can_poll always returns %TRUE.
 *
 * The default implementation of @write_nonblocking calls
 * g_pollable_output_stream_is_writable(), and then calls
 * g_output_stream_write() if it returns %TRUE. This means you only
 * need to override it if it is possible that your @is_writable
 * implementation may return %TRUE when the stream is not actually
 * writable.
 *
 * The default implementation of @writev_nonblocking calls
 * g_pollable_output_stream_write_nonblocking() for each vector, and converts
 * its return value and error (if set) to a #GPollableReturn. You should
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GPollableOutputStreamInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GPollableOutputStreamInterface.gIface);
  }

  alias CanPollFuncType = extern(C) bool function(GPollableOutputStream* stream);

  @property CanPollFuncType canPoll()
  {
    return cPtr!GPollableOutputStreamInterface.canPoll;
  }

  alias IsWritableFuncType = extern(C) bool function(GPollableOutputStream* stream);

  @property IsWritableFuncType isWritable()
  {
    return cPtr!GPollableOutputStreamInterface.isWritable;
  }

  alias CreateSourceFuncType = extern(C) GSource* function(GPollableOutputStream* stream, GCancellable* cancellable);

  @property CreateSourceFuncType createSource()
  {
    return cPtr!GPollableOutputStreamInterface.createSource;
  }

  alias WriteNonblockingFuncType = extern(C) ptrdiff_t function(GPollableOutputStream* stream, void* buffer, size_t count, GError** _err);

  @property WriteNonblockingFuncType writeNonblocking()
  {
    return cPtr!GPollableOutputStreamInterface.writeNonblocking;
  }

  alias WritevNonblockingFuncType = extern(C) GPollableReturn function(GPollableOutputStream* stream, const(GOutputVector)* vectors, size_t nVectors, size_t* bytesWritten, GError** _err);

  @property WritevNonblockingFuncType writevNonblocking()
  {
    return cPtr!GPollableOutputStreamInterface.writevNonblocking;
  }
}
