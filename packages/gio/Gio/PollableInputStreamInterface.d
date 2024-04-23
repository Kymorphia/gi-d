module Gio.PollableInputStreamInterface;

import GLib.Source;
import GLib.Types;
import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.Cancellable;
import Gio.PollableInputStream;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * The interface for pollable input streams.
 *
 * The default implementation of @can_poll always returns %TRUE.
 *
 * The default implementation of @read_nonblocking calls
 * g_pollable_input_stream_is_readable(), and then calls
 * g_input_stream_read() if it returns %TRUE. This means you only need
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GPollableInputStreamInterface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GPollableInputStreamInterface.gIface);
  }

  alias CanPollFuncType = extern(C) bool function(GPollableInputStream* stream);

  @property CanPollFuncType canPoll()
  {
    return cPtr!GPollableInputStreamInterface.canPoll;
  }

  alias IsReadableFuncType = extern(C) bool function(GPollableInputStream* stream);

  @property IsReadableFuncType isReadable()
  {
    return cPtr!GPollableInputStreamInterface.isReadable;
  }

  alias CreateSourceFuncType = extern(C) GSource* function(GPollableInputStream* stream, GCancellable* cancellable);

  @property CreateSourceFuncType createSource()
  {
    return cPtr!GPollableInputStreamInterface.createSource;
  }

  alias ReadNonblockingFuncType = extern(C) ptrdiff_t function(GPollableInputStream* stream, void* buffer, size_t count, GError** _err);

  @property ReadNonblockingFuncType readNonblocking()
  {
    return cPtr!GPollableInputStreamInterface.readNonblocking;
  }
}
