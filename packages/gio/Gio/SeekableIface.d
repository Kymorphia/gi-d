module Gio.SeekableIface;

import GLib.Types;
import GLib.c.functions;
import GObject.TypeInterface;
import GObject.Types;
import Gid.Gid;
import Gio.Cancellable;
import Gio.Seekable;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

/**
 * Provides an interface for implementing seekable functionality on I/O Streams.
 */
class SeekableIface
{
  GSeekableIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.SeekableIface");

    cInstance = *cast(GSeekableIface*)ptr;

    if (ownedRef)
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GSeekableIface))
  {
    return cast(T*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&cPtr!GSeekableIface.gIface);
  }

  alias TellFuncType = extern(C) long function(GSeekable* seekable);

  @property TellFuncType tell()
  {
    return cPtr!GSeekableIface.tell;
  }

  alias CanSeekFuncType = extern(C) bool function(GSeekable* seekable);

  @property CanSeekFuncType canSeek()
  {
    return cPtr!GSeekableIface.canSeek;
  }

  alias SeekFuncType = extern(C) bool function(GSeekable* seekable, long offset, GSeekType type, GCancellable* cancellable, GError** _err);

  @property SeekFuncType seek()
  {
    return cPtr!GSeekableIface.seek;
  }

  alias CanTruncateFuncType = extern(C) bool function(GSeekable* seekable);

  @property CanTruncateFuncType canTruncate()
  {
    return cPtr!GSeekableIface.canTruncate;
  }

  alias TruncateFnFuncType = extern(C) bool function(GSeekable* seekable, long offset, GCancellable* cancellable, GError** _err);

  @property TruncateFnFuncType truncateFn()
  {
    return cPtr!GSeekableIface.truncateFn;
  }
}
