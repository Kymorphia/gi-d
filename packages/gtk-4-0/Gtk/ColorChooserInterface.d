module Gtk.ColorChooserInterface;

import GObject.TypeInterface;
import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

class ColorChooserInterface
{
  GtkColorChooserInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.ColorChooserInterface");

    cInstance = *cast(GtkColorChooserInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property TypeInterface baseInterface()
  {
    return new TypeInterface(cast(GTypeInterface*)&(cast(GtkColorChooserInterface*)cPtr).baseInterface);
  }

  alias GetRgbaFuncType = extern(C) void function(GtkColorChooser* chooser, GdkRGBA* color);

  @property GetRgbaFuncType getRgba()
  {
    return (cast(GtkColorChooserInterface*)cPtr).getRgba;
  }

  alias SetRgbaFuncType = extern(C) void function(GtkColorChooser* chooser, const(GdkRGBA)* color);

  @property SetRgbaFuncType setRgba()
  {
    return (cast(GtkColorChooserInterface*)cPtr).setRgba;
  }

  alias AddPaletteFuncType = extern(C) void function(GtkColorChooser* chooser, GtkOrientation orientation, int colorsPerLine, int nColors, GdkRGBA* colors);

  @property AddPaletteFuncType addPalette()
  {
    return (cast(GtkColorChooserInterface*)cPtr).addPalette;
  }

  alias ColorActivatedFuncType = extern(C) void function(GtkColorChooser* chooser, const(GdkRGBA)* color);

  @property ColorActivatedFuncType colorActivated()
  {
    return (cast(GtkColorChooserInterface*)cPtr).colorActivated;
  }
}
