module Gtk.PadActionEntry;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * Struct defining a pad action entry.
 */
class PadActionEntry
{
  GtkPadActionEntry cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.PadActionEntry");

    cInstance = *cast(GtkPadActionEntry*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property PadActionType type()
  {
    return cast(PadActionType)(cast(GtkPadActionEntry*)cPtr).type;
  }

  @property void type(PadActionType propval)
  {
    (cast(GtkPadActionEntry*)cPtr).type = cast(GtkPadActionType)propval;
  }

  @property int index()
  {
    return (cast(GtkPadActionEntry*)cPtr).index;
  }

  @property void index(int propval)
  {
    (cast(GtkPadActionEntry*)cPtr).index = propval;
  }

  @property int mode()
  {
    return (cast(GtkPadActionEntry*)cPtr).mode;
  }

  @property void mode(int propval)
  {
    (cast(GtkPadActionEntry*)cPtr).mode = propval;
  }

  @property string label()
  {
    return (cast(GtkPadActionEntry*)cPtr).label.fromCString(false);
  }

  @property void label(string propval)
  {
    safeFree(cast(void*)(cast(GtkPadActionEntry*)cPtr).label);
    (cast(GtkPadActionEntry*)cPtr).label = propval.toCString(true);
  }

  @property string actionName()
  {
    return (cast(GtkPadActionEntry*)cPtr).actionName.fromCString(false);
  }

  @property void actionName(string propval)
  {
    safeFree(cast(void*)(cast(GtkPadActionEntry*)cPtr).actionName);
    (cast(GtkPadActionEntry*)cPtr).actionName = propval.toCString(true);
  }
}
