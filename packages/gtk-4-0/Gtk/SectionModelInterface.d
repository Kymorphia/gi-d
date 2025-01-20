module Gtk.SectionModelInterface;

import Gid.gid;
import Gtk.Types;
import Gtk.c.functions;
import Gtk.c.types;

/**
 * The list of virtual functions for the `GtkSectionModel` interface.
 * No function must be implemented, but unless `GtkSectionModel::get_section$(LPAREN)$(RPAREN)`
 * is implemented, the whole model will just be a single section.
 */
class SectionModelInterface
{
  GtkSectionModelInterface cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gtk.SectionModelInterface");

    cInstance = *cast(GtkSectionModelInterface*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  alias GetSectionFuncType = extern(C) void function(GtkSectionModel* self, uint position, uint* outStart, uint* outEnd);

  @property GetSectionFuncType getSection()
  {
    return (cast(GtkSectionModelInterface*)cPtr).getSection;
  }
}
