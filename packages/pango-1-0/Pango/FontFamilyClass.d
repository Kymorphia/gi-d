module Pango.FontFamilyClass;

import GObject.ObjectClass;
import Gid.gid;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

class FontFamilyClass
{
  PangoFontFamilyClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.FontFamilyClass");

    cInstance = *cast(PangoFontFamilyClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(PangoFontFamilyClass*)cPtr).parentClass);
  }

  alias ListFacesFuncType = extern(C) void function(PangoFontFamily* family, PangoFontFace*** faces, int* nFaces);

  @property ListFacesFuncType listFaces()
  {
    return (cast(PangoFontFamilyClass*)cPtr).listFaces;
  }

  alias GetNameFuncType = extern(C) const(char)* function(PangoFontFamily* family);

  @property GetNameFuncType getName()
  {
    return (cast(PangoFontFamilyClass*)cPtr).getName;
  }

  alias IsMonospaceFuncType = extern(C) bool function(PangoFontFamily* family);

  @property IsMonospaceFuncType isMonospace()
  {
    return (cast(PangoFontFamilyClass*)cPtr).isMonospace;
  }

  alias IsVariableFuncType = extern(C) bool function(PangoFontFamily* family);

  @property IsVariableFuncType isVariable()
  {
    return (cast(PangoFontFamilyClass*)cPtr).isVariable;
  }

  alias GetFaceFuncType = extern(C) PangoFontFace* function(PangoFontFamily* family, const(char)* name);

  @property GetFaceFuncType getFace()
  {
    return (cast(PangoFontFamilyClass*)cPtr).getFace;
  }
}
