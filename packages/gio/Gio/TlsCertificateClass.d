module Gio.TlsCertificateClass;

import GLib.c.functions;
import GObject.ObjectClass;
import GObject.Types;
import Gid.Gid;
import Gio.SocketConnectable;
import Gio.TlsCertificate;
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
      g_free(ptr);
  }

  T* cPtr(T)()
  if (is(T == GTlsCertificateClass))
  {
    return cast(T*)&cInstance;
  }

  @property ObjectClass parentClass()
  {
    return new ObjectClass(cast(GObjectClass*)&cPtr!GTlsCertificateClass.parentClass);
  }

  alias VerifyFuncType = extern(C) GTlsCertificateFlags function(GTlsCertificate* cert, GSocketConnectable* identity, GTlsCertificate* trustedCa);

  @property VerifyFuncType verify()
  {
    return cPtr!GTlsCertificateClass.verify;
  }
}
