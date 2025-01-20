module Gsk.NglRenderer;

import Gid.gid;
import Gsk.Renderer;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

class NglRenderer : Renderer
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  static GType getType()
  {
    return gsk_ngl_renderer_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  this()
  {
    GskRenderer* _cretval;
    _cretval = gsk_ngl_renderer_new();
    this(_cretval, true);
  }
}
