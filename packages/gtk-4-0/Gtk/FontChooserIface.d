module Gtk.FontChooserIface;

import GObject.TypeInterface;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class FontChooserIface
{
  GtkFontChooserIface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.FontChooserIface");

    cInstance = *cast(GtkFontChooserIface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface baseIface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GtkFontChooserIface*)cPtr).baseIface);
  }

  alias GetFontFamilyFuncType = extern(C) PangoFontFamily* function(GtkFontChooser* fontchooser);

  @property GetFontFamilyFuncType getFontFamily()
  {
    return (cast(GtkFontChooserIface*)cPtr).getFontFamily;
  }

  alias GetFontFaceFuncType = extern(C) PangoFontFace* function(GtkFontChooser* fontchooser);

  @property GetFontFaceFuncType getFontFace()
  {
    return (cast(GtkFontChooserIface*)cPtr).getFontFace;
  }

  alias GetFontSizeFuncType = extern(C) int function(GtkFontChooser* fontchooser);

  @property GetFontSizeFuncType getFontSize()
  {
    return (cast(GtkFontChooserIface*)cPtr).getFontSize;
  }

  alias SetFilterFuncFuncType = extern(C) void function(GtkFontChooser* fontchooser, GtkFontFilterFunc filter, void* userData, GDestroyNotify destroy);

  @property SetFilterFuncFuncType setFilterFunc()
  {
    return (cast(GtkFontChooserIface*)cPtr).setFilterFunc;
  }

  alias FontActivatedFuncType = extern(C) void function(GtkFontChooser* chooser, const(char)* fontname);

  @property FontActivatedFuncType fontActivated()
  {
    return (cast(GtkFontChooserIface*)cPtr).fontActivated;
  }

  alias SetFontMapFuncType = extern(C) void function(GtkFontChooser* fontchooser, PangoFontMap* fontmap);

  @property SetFontMapFuncType setFontMap()
  {
    return (cast(GtkFontChooserIface*)cPtr).setFontMap;
  }

  alias GetFontMapFuncType = extern(C) PangoFontMap* function(GtkFontChooser* fontchooser);

  @property GetFontMapFuncType getFontMap()
  {
    return (cast(GtkFontChooserIface*)cPtr).getFontMap;
  }
}
