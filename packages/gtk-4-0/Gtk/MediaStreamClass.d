module Gtk.MediaStreamClass;

import GObject.ObjectClass;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class MediaStreamClass
{
  GtkMediaStreamClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.MediaStreamClass");

    cInstance = *cast(GtkMediaStreamClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GtkMediaStreamClass*)cPtr).parentClass);
  }

  alias PlayFuncType = extern(C) bool function(GtkMediaStream* self);

  @property PlayFuncType play()
  {
    return (cast(GtkMediaStreamClass*)cPtr).play;
  }

  alias PauseFuncType = extern(C) void function(GtkMediaStream* self);

  @property PauseFuncType pause()
  {
    return (cast(GtkMediaStreamClass*)cPtr).pause;
  }

  alias SeekFuncType = extern(C) void function(GtkMediaStream* self, long timestamp);

  @property SeekFuncType seek()
  {
    return (cast(GtkMediaStreamClass*)cPtr).seek;
  }

  alias UpdateAudioFuncType = extern(C) void function(GtkMediaStream* self, bool muted, double volume);

  @property UpdateAudioFuncType updateAudio()
  {
    return (cast(GtkMediaStreamClass*)cPtr).updateAudio;
  }

  alias RealizeFuncType = extern(C) void function(GtkMediaStream* self, GdkSurface* surface);

  @property RealizeFuncType realize()
  {
    return (cast(GtkMediaStreamClass*)cPtr).realize;
  }

  alias UnrealizeFuncType = extern(C) void function(GtkMediaStream* self, GdkSurface* surface);

  @property UnrealizeFuncType unrealize()
  {
    return (cast(GtkMediaStreamClass*)cPtr).unrealize;
  }
}
