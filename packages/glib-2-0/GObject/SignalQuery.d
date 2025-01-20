module GObject.SignalQuery;

import GObject.Types;
import GObject.c.functions;
import GObject.c.types;
import Gid.gid;

/**
 * A structure holding in-depth information for a specific signal.
 * See also: [GObject.Global.signalQuery]
 */
class SignalQuery
{
  GSignalQuery cInstance;

  this(void* ptr, bool ownedRef = false)
  {
    if (!ptr)
      throw new GidConstructException("Null instance pointer for GObject.SignalQuery");

    cInstance = *cast(GSignalQuery*)ptr;

    if (ownedRef)
      safeFree(ptr);
  }

  void* cPtr()
  {
    return cast(void*)&cInstance;
  }

  @property uint signalId()
  {
    return (cast(GSignalQuery*)cPtr).signalId;
  }

  @property void signalId(uint propval)
  {
    (cast(GSignalQuery*)cPtr).signalId = propval;
  }

  @property string signalName()
  {
    return (cast(GSignalQuery*)cPtr).signalName.fromCString(false);
  }

  @property void signalName(string propval)
  {
    safeFree(cast(void*)(cast(GSignalQuery*)cPtr).signalName);
    (cast(GSignalQuery*)cPtr).signalName = propval.toCString(true);
  }

  @property GType itype()
  {
    return (cast(GSignalQuery*)cPtr).itype;
  }

  @property void itype(GType propval)
  {
    (cast(GSignalQuery*)cPtr).itype = propval;
  }

  @property SignalFlags signalFlags()
  {
    return cast(SignalFlags)(cast(GSignalQuery*)cPtr).signalFlags;
  }

  @property void signalFlags(SignalFlags propval)
  {
    (cast(GSignalQuery*)cPtr).signalFlags = cast(GSignalFlags)propval;
  }

  @property GType returnType()
  {
    return (cast(GSignalQuery*)cPtr).returnType;
  }

  @property void returnType(GType propval)
  {
    (cast(GSignalQuery*)cPtr).returnType = propval;
  }

  @property uint nParams()
  {
    return (cast(GSignalQuery*)cPtr).nParams;
  }

  @property void nParams(uint propval)
  {
    (cast(GSignalQuery*)cPtr).nParams = propval;
  }
}
