module Gio.PollableInputStreamInterface;

import GObject.TypeInterface;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The interface for pollable input streams.
 * The default implementation of @can_poll always returns %TRUE.
 * The default implementation of @read_nonblocking calls
 * [Gio.PollableInputStream.isReadable], and then calls
 * [Gio.InputStream.read] if it returns %TRUE. This means you only need
 * to override it if it is possible that your @is_readable
 * implementation may return %TRUE when the stream is not actually
 * readable.
 */
class PollableInputStreamInterface
{
  GPollableInputStreamInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.PollableInputStreamInterface");

    cInstance = *cast(GPollableInputStreamInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GPollableInputStreamInterface*)cPtr).gIface);
  }

  alias CanPollFuncType = extern(C) bool function(GPollableInputStream* stream);

  @property CanPollFuncType canPoll()
  {
    return (cast(GPollableInputStreamInterface*)cPtr).canPoll;
  }

  alias IsReadableFuncType = extern(C) bool function(GPollableInputStream* stream);

  @property IsReadableFuncType isReadable()
  {
    return (cast(GPollableInputStreamInterface*)cPtr).isReadable;
  }

  alias CreateSourceFuncType = extern(C) GSource* function(GPollableInputStream* stream, GCancellable* cancellable);

  @property CreateSourceFuncType createSource()
  {
    return (cast(GPollableInputStreamInterface*)cPtr).createSource;
  }

  alias ReadNonblockingFuncType = extern(C) ptrdiff_t function(GPollableInputStream* stream, void* buffer, size_t count, GError** _err);

  @property ReadNonblockingFuncType readNonblocking()
  {
    return (cast(GPollableInputStreamInterface*)cPtr).readNonblocking;
  }
}
