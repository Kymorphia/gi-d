module Graphene.Simd4X4F;

import Gid.gid;
import Graphene.Types;
import Graphene.c.functions;
import Graphene.c.types;

class Simd4X4F
{
  graphene_simd4x4f_t cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Graphene.Simd4X4F");

    cInstance = *cast(graphene_simd4x4f_t*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }
}
