module Pango.FontMapClass;

import GObject.ObjectClass;
import Gid.gid;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

/**
 * The `PangoFontMapClass` structure holds the virtual functions for
 * a particular `PangoFontMap` implementation.
 */
class FontMapClass
{
  PangoFontMapClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.FontMapClass");

    cInstance = *cast(PangoFontMapClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(PangoFontMapClass*)cPtr).parentClass);
  }

  alias LoadFontFuncType = extern(C) PangoFont* function(PangoFontMap* fontmap, PangoContext* context, const(PangoFontDescription)* desc);

  @property LoadFontFuncType loadFont()
  {
    return (cast(PangoFontMapClass*)cPtr).loadFont;
  }

  alias ListFamiliesFuncType = extern(C) void function(PangoFontMap* fontmap, PangoFontFamily*** families, int* nFamilies);

  @property ListFamiliesFuncType listFamilies()
  {
    return (cast(PangoFontMapClass*)cPtr).listFamilies;
  }

  alias LoadFontsetFuncType = extern(C) PangoFontset* function(PangoFontMap* fontmap, PangoContext* context, const(PangoFontDescription)* desc, PangoLanguage* language);

  @property LoadFontsetFuncType loadFontset()
  {
    return (cast(PangoFontMapClass*)cPtr).loadFontset;
  }

  @property string shapeEngineType()
  {
    return (cast(PangoFontMapClass*)cPtr).shapeEngineType.fromCString(false);
  }

  alias GetSerialFuncType = extern(C) uint function(PangoFontMap* fontmap);

  @property GetSerialFuncType getSerial()
  {
    return (cast(PangoFontMapClass*)cPtr).getSerial;
  }

  alias ChangedFuncType = extern(C) void function(PangoFontMap* fontmap);

  @property ChangedFuncType changed()
  {
    return (cast(PangoFontMapClass*)cPtr).changed;
  }

  alias GetFamilyFuncType = extern(C) PangoFontFamily* function(PangoFontMap* fontmap, const(char)* name);

  @property GetFamilyFuncType getFamily()
  {
    return (cast(PangoFontMapClass*)cPtr).getFamily;
  }
}
