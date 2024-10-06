module Pango.FontFaceClass;

import GObject.ObjectClass;
import Gid.gid;
import Pango.Types;
import Pango.c.functions;
import Pango.c.types;

class FontFaceClass
{
  PangoFontFaceClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Pango.FontFaceClass");

    cInstance = *cast(PangoFontFaceClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(PangoFontFaceClass*)cPtr).parentClass);
  }

  alias GetFaceNameFuncType = extern(C) const(char)* function(PangoFontFace* face);

  @property GetFaceNameFuncType getFaceName()
  {
    return (cast(PangoFontFaceClass*)cPtr).getFaceName;
  }

  alias DescribeFuncType = extern(C) PangoFontDescription* function(PangoFontFace* face);

  @property DescribeFuncType describe()
  {
    return (cast(PangoFontFaceClass*)cPtr).describe;
  }

  alias ListSizesFuncType = extern(C) void function(PangoFontFace* face, int** sizes, int* nSizes);

  @property ListSizesFuncType listSizes()
  {
    return (cast(PangoFontFaceClass*)cPtr).listSizes;
  }

  alias IsSynthesizedFuncType = extern(C) bool function(PangoFontFace* face);

  @property IsSynthesizedFuncType isSynthesized()
  {
    return (cast(PangoFontFaceClass*)cPtr).isSynthesized;
  }

  alias GetFamilyFuncType = extern(C) PangoFontFamily* function(PangoFontFace* face);

  @property GetFamilyFuncType getFamily()
  {
    return (cast(PangoFontFaceClass*)cPtr).getFamily;
  }
}
