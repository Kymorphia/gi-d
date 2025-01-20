module Gio.SeekableIface;

import GObject.TypeInterface;
import Gid.gid;
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
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface gIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GSeekableIface*)cPtr).gIface);
  }

  alias TellFuncType = extern(C) long function(GSeekable* seekable);

  @property TellFuncType tell()
  {
    return (cast(GSeekableIface*)cPtr).tell;
  }

  alias CanSeekFuncType = extern(C) bool function(GSeekable* seekable);

  @property CanSeekFuncType canSeek()
  {
    return (cast(GSeekableIface*)cPtr).canSeek;
  }

  alias SeekFuncType = extern(C) bool function(GSeekable* seekable, long offset, GSeekType type, GCancellable* cancellable, GError** _err);

  @property SeekFuncType seek()
  {
    return (cast(GSeekableIface*)cPtr).seek;
  }

  alias CanTruncateFuncType = extern(C) bool function(GSeekable* seekable);

  @property CanTruncateFuncType canTruncate()
  {
    return (cast(GSeekableIface*)cPtr).canTruncate;
  }

  alias TruncateFnFuncType = extern(C) bool function(GSeekable* seekable, long offset, GCancellable* cancellable, GError** _err);

  @property TruncateFnFuncType truncateFn()
  {
    return (cast(GSeekableIface*)cPtr).truncateFn;
  }
}
