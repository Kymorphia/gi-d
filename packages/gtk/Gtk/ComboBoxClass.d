module Gtk.ComboBoxClass;

import Gid.gid;
import Gtk.Types;
import Gtk.WidgetClass;
import Gtk.c.functions;
import Gtk.c.types;

class ComboBoxClass
{
  GtkComboBoxClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.ComboBoxClass");

    cInstance = *cast(GtkComboBoxClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property WidgetClass parentClass()
  {
    return new WidgetClass(cast(GtkWidgetClass*)&(cast(GtkComboBoxClass*)cPtr).parentClass);
  }

  alias ChangedFuncType = extern(C) void function(GtkComboBox* comboBox);

  @property ChangedFuncType changed()
  {
    return (cast(GtkComboBoxClass*)cPtr).changed;
  }

  alias FormatEntryTextFuncType = extern(C) char* function(GtkComboBox* comboBox, const(char)* path);

  @property FormatEntryTextFuncType formatEntryText()
  {
    return (cast(GtkComboBoxClass*)cPtr).formatEntryText;
  }

  alias ActivateFuncType = extern(C) void function(GtkComboBox* comboBox);

  @property ActivateFuncType activate()
  {
    return (cast(GtkComboBoxClass*)cPtr).activate;
  }
}
