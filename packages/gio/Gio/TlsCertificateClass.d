module Gio.TlsCertificateClass;

import GObject.ObjectClass;
import Gid.gid;
import Gio.Types;
import Gio.c.functions;
import Gio.c.types;

class TlsCertificateClass
{
  GTlsCertificateClass cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for Gio.TlsCertificateClass");

    cInstance = *cast(GTlsCertificateClass*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&(cast(GTlsCertificateClass*)cPtr).parentClass);
  }

  alias VerifyFuncType = extern(C) GTlsCertificateFlags function(GTlsCertificate* cert, GSocketConnectable* identity, GTlsCertificate* trustedCa);

  @property VerifyFuncType verify()
  {
    return (cast(GTlsCertificateClass*)cPtr).verify;
  }
}
