module Gtk.RecentData;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Meta-data to be passed to [Gtk.RecentManager.addFull] when
 * registering a recently used resource.
 */
class RecentData
{
  GtkRecentData cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.RecentData");

    cInstance = *cast(GtkRecentData*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property string displayName()
  {
    return (cast(GtkRecentData*)cPtr).displayName.fromCString(false);
  }

  @property void displayName(string propval)
  {
    safeFree(cast(void*)(cast(GtkRecentData*)cPtr).displayName);
    (cast(GtkRecentData*)cPtr).displayName = propval.toCString(true);
  }

  @property string description()
  {
    return (cast(GtkRecentData*)cPtr).description.fromCString(false);
  }

  @property void description(string propval)
  {
    safeFree(cast(void*)(cast(GtkRecentData*)cPtr).description);
    (cast(GtkRecentData*)cPtr).description = propval.toCString(true);
  }

  @property string mimeType()
  {
    return (cast(GtkRecentData*)cPtr).mimeType.fromCString(false);
  }

  @property void mimeType(string propval)
  {
    safeFree(cast(void*)(cast(GtkRecentData*)cPtr).mimeType);
    (cast(GtkRecentData*)cPtr).mimeType = propval.toCString(true);
  }

  @property string appName()
  {
    return (cast(GtkRecentData*)cPtr).appName.fromCString(false);
  }

  @property void appName(string propval)
  {
    safeFree(cast(void*)(cast(GtkRecentData*)cPtr).appName);
    (cast(GtkRecentData*)cPtr).appName = propval.toCString(true);
  }

  @property string appExec()
  {
    return (cast(GtkRecentData*)cPtr).appExec.fromCString(false);
  }

  @property void appExec(string propval)
  {
    safeFree(cast(void*)(cast(GtkRecentData*)cPtr).appExec);
    (cast(GtkRecentData*)cPtr).appExec = propval.toCString(true);
  }

  @property bool isPrivate()
  {
    return (cast(GtkRecentData*)cPtr).isPrivate;
  }

  @property void isPrivate(bool propval)
  {
    (cast(GtkRecentData*)cPtr).isPrivate = propval;
  }
}
