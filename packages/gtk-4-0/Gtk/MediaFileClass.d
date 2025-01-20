module Gtk.MediaFileClass;

import Gid.gid;
import Gtk.MediaStreamClass;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class MediaFileClass
{
  GtkMediaFileClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.MediaFileClass");

    cInstance = *cast(GtkMediaFileClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property MediaStreamClass parentClass()
  {
    return new MediaStreamClass(cast(GtkMediaStreamClass*)&(cast(GtkMediaFileClass*)cPtr).parentClass);
  }

  alias OpenFuncType = extern(C) void function(GtkMediaFile* self);

  @property OpenFuncType open()
  {
    return (cast(GtkMediaFileClass*)cPtr).open;
  }

  alias CloseFuncType = extern(C) void function(GtkMediaFile* self);

  @property CloseFuncType close()
  {
    return (cast(GtkMediaFileClass*)cPtr).close;
  }
}
