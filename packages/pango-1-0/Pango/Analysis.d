module Pango.Analysis;

import GObject.ObjectG;
import Gid.gid;
import Pango.Font;
import Pango.PgLanguage;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * The `PangoAnalysis` structure stores information about
 * the properties of a segment of text.
 */
class Analysis
{
  PangoAnalysis cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.Analysis");

    cInstance = *cast(PangoAnalysis*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property Font font()
  {
    return ObjectG.getDObject!Font((cast(PangoAnalysis*)cPtr).font, false);
  }

  @property ubyte level()
  {
    return (cast(PangoAnalysis*)cPtr).level;
  }

  @property void level(ubyte propval)
  {
    (cast(PangoAnalysis*)cPtr).level = propval;
  }

  @property ubyte gravity()
  {
    return (cast(PangoAnalysis*)cPtr).gravity;
  }

  @property void gravity(ubyte propval)
  {
    (cast(PangoAnalysis*)cPtr).gravity = propval;
  }

  @property ubyte flags()
  {
    return (cast(PangoAnalysis*)cPtr).flags;
  }

  @property void flags(ubyte propval)
  {
    (cast(PangoAnalysis*)cPtr).flags = propval;
  }

  @property ubyte script()
  {
    return (cast(PangoAnalysis*)cPtr).script;
  }

  @property void script(ubyte propval)
  {
    (cast(PangoAnalysis*)cPtr).script = propval;
  }

  @property PgLanguage language()
  {
    return new PgLanguage(cast(PangoLanguage*)(cast(PangoAnalysis*)cPtr).language);
  }
}
